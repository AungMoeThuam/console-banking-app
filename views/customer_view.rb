require_relative '../constants/transaction_type'
require_relative '../utilities/input_functions'
require_relative '../utilities/add_space'
require_relative '../utilities/time'
require_relative '../views/user_view'
class CustomerView < UserView

  def initialize(user)
    super(user)
  end

  def display_home_menu
    puts "\nWelcome to #{@user.name}"
    puts "Account No #{@user.account_no}"
    puts "Balance - #{@user.balance}"
    puts "1: deposit"
    puts "2: withdraw"
    puts "3: transfer"
    puts "4: loan"
    puts "5: view transactions history"
    puts "6: exit"
    return read_integer("Enter your choice: ")
  end

  def display_deposit_menu
    read_float("enter deposit amount or 0 to exit:  ")
  end

  def display_withdraw_menu
      read_float("enter withdraw amount or 0 to exit: ")
  end

  def display_transfer_menu
    recipient = read_string("enter receiver bank account number or 0 to exit: ")
    amount = read_float("enter amount to transfer 0 to exist: ")
    return {"recipient_no" => recipient, "amount" => amount}
  end



end

