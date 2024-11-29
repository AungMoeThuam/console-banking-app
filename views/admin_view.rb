require_relative '../utilities/input_functions'
require_relative '../views/user_view'

class AdminView < UserView

  def initialize(admin)
    super(admin)
  end

  def display_home_menu
    puts ""
    puts "1. account activation and deactivation"
    puts "2. register a new manager"
    puts "3. check user transactions"
    puts "4. check user info"
    puts "5. bank loan approval"
    puts "6. exit"
    read_integer("Enter your choice: ")
  end

  def display_activation_option_menu
    puts ""
    puts "1: activation"
    puts "2: deactivation"
    puts "3: exit"
    read_integer("Enter your choice: ")
  end

  def display_register_new_manager_menu
    puts ""
    name = read_string("Enter manager name: ")
    email = read_string("Enter email: ")
    password = read_string("Enter password: ")
    { "name" => name, "email" => email, "password" => password }
  end

  def display_no_loans_exist
    puts "There is no loan applied from customers yet!"
    read_string("Press enter to continue...")
  end

  def display_loan_approval_confirm_menu
    read_integer("Are you sure to approve this loan? 1 for approve, 0 to exit: ")
  end

  def display_activate_confirm_menu
    read_integer("Are you sure to activate this account? 1 for yes, 0 for no : ")
  end

  def display_deactivate_confirm_menu
    read_integer("Are you sure to deactivate this account? 1 for yes, 0 for no : ")
  end

  def display_user_info(user)
    puts ""
    puts "Name - #{user.name}"
    puts "Email - #{user.email}"
    puts "Account No - #{user.account_no}"
    puts "Role - #{user.role}"
    puts "Current Account Activation Status - #{user.is_activated}"
  end

  def display_unactivated_user(users)

    # printing table header
    puts "#{add_space_to_right("Name")}#{add_space_to_right("Account No")}#{add_space_to_right("Status")}"
    puts "-" * 115

    # printing table body
    i = 0
    while i < users.length
      print add_space_to_right(users[i].name)
      print add_space_to_right(users[i].account_no)
      print add_space_to_right(users[i].is_activated)
      print "\n"
      i += 1
    end
  end

  # messages
  def display_manager_already_exist_message
    puts "Manager already exist!"
    read_string("Press enter to continue...")
  end

  def display_manager_register_success_message
    puts "Registration successful!"
    read_string("Press enter to continue...")
  end

  def display_activation_success_message(account_no)
    puts "user with account number #{account_no} is activated successfully!"
    read_string("Press enter to continue...")
  end

  def display_deactivation_success_message(account_no)
    puts "user with account number #{account_no} is deactivated successfully!"
    read_string("Press enter to continue...")
  end

  def display_approved_loan_message
    puts "You have approved this loan!"
    read_string("Press enter to continue...")
  end

end