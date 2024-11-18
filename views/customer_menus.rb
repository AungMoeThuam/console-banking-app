require_relative '../utilities/input_functions'
def display_bank_acc_home_menu()
  puts "1: balance"
  puts "2: deposit"
  puts "3: withdraw"
  puts "4: transfer"
  puts "5: exit"
  return read_integer("Enter your choice: ")
end

