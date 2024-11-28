class UserView

  def initialize(user)
    @user = user
  end

  def print_transaction_amount(transaction, being_checked_user_account_no)
    if transaction.type == Transaction_Type::DEPOSIT
      print add_space_to_right("+RM #{transaction.amount}")
    elsif transaction.type == Transaction_Type::TRANSFER && transaction.recipient == being_checked_user_account_no
      print add_space_to_right("+RM #{transaction.amount}")
    else
      print add_space_to_right("-RM #{transaction.amount}")
    end
  end

  def display_transactions(user)
    number_of_transactions = user.transactions.length
    if number_of_transactions == 0
      puts "There is no transaction yet!"
      puts "press enter to continue..."
      gets
      return
    end
    transactions = user.transactions
    transactions_pages = (number_of_transactions.to_f / 5).ceil # Calculate the number of pages
    current_page = 1

    while true
      # Calculate the starting and ending indices for the current page
      start_index = (current_page - 1) * 5
      end_index = [start_index + 4, number_of_transactions - 1].min # Ensure we don't go out of bounds

      # Print table header
      puts "\nTransactions"
      puts "#{add_space_to_right("ID")}#{add_space_to_right("TYPE")}#{ add_space_to_right("Amount")}#{ add_space_to_right("Date")}#{add_space_to_right("To")}#{add_space_to_right("From")}"
      puts "-" * 126

      # Loop to print transactions for the current page
      i = start_index
      while i <= end_index
        transaction = transactions[i]
        print add_space_to_right(transaction.id)
        print add_space_to_right(transaction.type)

        print_transaction_amount(transaction, user.account_no)
        print add_space_to_right(parse_time(transaction.date))
        if transaction.type == Transaction_Type::TRANSFER
          print "#{add_space_to_right(transaction.recipient)}"
          print "#{ add_space_to_right(transaction.sender)}"
        else
          print add_space_to_right("")
          print add_space_to_right("")
        end
        print "\n"
        i += 1
      end

      # Display current page and available page options
      puts "Current page #{current_page} of #{transactions_pages}"

      # Display available pages for navigation
      j = 1
      while j <= transactions_pages
        puts "#{j}: page #{j}"
        j += 1
      end
      puts "\n0: exit"

      current_page = read_integer("Enter page number to view or 0 to exit: ")

      # Exit the loop if user chooses 0
      if current_page == 0
        return
      elsif current_page < 1 || current_page > transactions_pages
        puts "Invalid page number. Please try again."
      end
    end
  end

  def display_asking_user_acc_number_menu
    read_string("enter account number or 0 to exit: ")
  end

  def display_invalid_choice_message
    puts "Invalid Choice!"
  end

  def display_user_not_found_message(user_account_no)
    puts "There is no user with account no #{user_account_no}"
    read_string("Press enter to continue...")
  end

end