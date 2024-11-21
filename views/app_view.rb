require_relative '../utilities/input_functions'
require_relative '../utilities/border_text'
class AppView
  def display_home_menu
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
    acc_type = [1,2,3]
    while true
      puts "chooce bank account type"
      puts "1. savings"
      puts "2. current"
      puts "3. fixed"
      bank_acc_type = read_integer("enter your choice: ")
      if acc_type.include?(bank_acc_type)
        break
      else
        puts "invalid choice! try again!"
      end
    end
    return {"name"=>name,"email" => email, "password" => password,"bank_acc_type": bank_acc_type}
  end
end