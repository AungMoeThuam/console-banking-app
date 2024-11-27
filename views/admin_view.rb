
require_relative '../utilities/input_functions'
require_relative '../views/user_view'
class AdminView < UserView


  def display_home_menu
    puts "1. change password"
    puts "2. account activation and deactivation"
    puts "3. register a new manager"
    puts "4. check user transactions"
    puts "5. check user info"
    puts "6. exit"
    return read_integer("Enter your choice: ")

  end

  def display_activation_option_menu
    puts "1: activation"
    puts "2: deactivation"
    puts "3: exit"
    return  read_integer("Enter your choice: ")
  end
  def display_register_new_manager_menu
    name = read_string("Enter manager name: ")
    email = read_string("Enter email: ")
    password = read_string("Enter password: ")
    return {"name"=>name, "email"=>email, "password"=>password}
  end

  def display_asking_user_info_menu
      read_string("enter account number or 0 to exit: ")
  end

  def display_activate_confirm_menu
    read_integer("Are you sure to activate this account? 1 for yes, 0 for no : ")
  end

  def display_deactivate_confirm_menu
    read_integer("Are you sure to deactivate this account? 1 for yes, 0 for no : ")
  end

  def display_user_info(user)
    puts "\nName - #{user.name}"
    puts "Email - #{user.email}"
    puts "Account No - #{user.account_no}"
    puts "Role - #{user.role}"
    puts "Current Account Activation Status - #{user.is_activated}"
  end



end