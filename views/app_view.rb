require_relative '../utilities/input_functions'
require_relative '../utilities/border_text'

class AppView
  def display_home_menu
    puts ""
    border_text("AM Banking App")
    center_text("Welcome"," ")
    puts "1: login"
    puts "2: register"
    puts "3: exit"
    choice = read_integer("enter your choice: ")
    return choice
  end

  def display_login_menu
    email = read_string("enter your email: ")
    password = read_string("enter your password: ")
    return {"email" => email, "password" => password}
  end

  def display_register_menu
    name = read_string("enter your name: ")
    email = read_string("enter your email: ")
    password = read_string("enter your password: ")

    return {"name"=>name,"email" => email, "password" => password}
  end
end