require_relative '../utilities/input_functions'
require_relative '../views/user_view'
class ManagerView < UserView

  def initialize(user)
    @user = user
  end
  def display_home_menu
    puts "1. check transactions for a customer"
    puts "2. check a user account info"
    puts "5. exit"
    read_integer("Enter your choice: ")
  end

  def display_checking_transactions_menu
    read_string("enter bank account number or 0 to exit: ")
  end


  def display_checking_customer_info_menu
    read_string("enter bank account number or 0 to exit: ")
  end

  def display_customer_info(customer)
    puts "\nName - #{customer.name}"
    puts "Email - #{customer.email}"
    puts "Account No - #{customer.account_no}"
    puts "Account Activation - #{customer.is_activated}"
    read_string("Press enter to continue...")
  end

end