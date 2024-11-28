require_relative '../utilities/input_functions'
require_relative '../utilities/border_text'

class AppView
  def display_home_menu
    puts ""
    border_text("AM Banking App")
    center_text("Welcome", " ")
    puts "1: login"
    puts "2: register"
    puts "3: exit"
    read_integer("enter your choice: ")
  end

  def display_login_menu
    puts ""
    email = read_string("enter your email: ")
    password = read_string("enter your password: ")
    { "email" => email, "password" => password }
  end

  def display_register_menu
    puts ""
    name = read_string("enter your name: ")
    email = read_string("enter your email: ")
    password = read_string("enter your password: ")

    { "name" => name, "email" => email, "password" => password }
  end

  #messages
  def display_invalid_login_message
    puts "Invalid email and password!"
  end

  def display_unactivated_account_message
    puts "sorry your account is not activated!"
  end

  def display_user_already_exist_message
    puts "User already registered!"
  end
  def display_register_success_message
    puts "Registration successful!"
    read_string("Press enter to continue...")
  end
end