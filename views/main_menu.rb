require_relative "../utilities/input_functions"
require_relative '../utilities/border_text'
require_relative '../utilities/center_text'
def display_main_menu
  border_text("AM Banking App")
  center_text("Welcome"," ")
  puts "1: login"
  puts "2: register"
  puts "3: exit"
  choice = read_integer("enter your choice: ")
  return choice
end

def display_login_menu
  email = read_string("Enter Email: ")
  password = read_string("Enter Password: ")
  login_credential = {"email" => email, "password" => password}
  return login_credential
end

def display_register_menu
  name = read_string("Enter Name: ")
  email = read_string("Enter Email: ")
  password = ""
  while true
    password = read_string("Enter Password: ")
    confirm_password = read_string("Enter Confirm Password: ")
    if password == confirm_password
      break
    else
      puts "password does not match! try again."
    end
  end
  new_registration = {"name" => name, "email" => email, "password" => password}
  return new_registration
end





