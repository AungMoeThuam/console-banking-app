require_relative '../utilities/input_functions'
def display_customer_home_menu()
  puts "1. savings account"
  puts "2. current account"
  puts "3. fixed account"
  puts "5. exit"
  return read_integer("Eneter your choice: ")
end

def display_manager_home_menu()
  puts "1. check transactions for a customer"
  puts "2. bank account activation"
  puts "5. exit"
end

def display_admin_home_menu()
  puts "1. change password"
  puts "2. check transactions for a customer"
  puts "3. create or delete a manager account"
  puts "4. freeze customer accounts"
  puts "5. exit"
end

