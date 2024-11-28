require_relative '../utilities/input_functions'
require_relative '../views/user_view'
class ManagerView < UserView

  def initialize(manager)
    super(manager)
  end
  def display_home_menu
    puts ""
    puts "1. check transactions for a customer"
    puts "2. check a user account info"
    puts "5. exit"
    read_integer("Enter your choice: ")
  end


  def display_customer_info(customer)
    puts ""
    puts "Name - #{customer.name}"
    puts "Email - #{customer.email}"
    puts "Account No - #{customer.account_no}"
    puts "Account Activation - #{customer.is_activated}"
    puts "Loan - #{customer.loan ? customer.loan.amount : "None" }"
    read_string("Press enter to continue...")
  end

end