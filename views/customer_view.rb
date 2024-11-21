class CustomerView

  def initialize(customer)
    @customer = customer
  end

  def display_home_menu()
    puts "1. savings account"
    puts "2. current account"
    puts "3. fixed account"
    puts "5. exit"
    return read_integer("Eneter your choice: ")
  end

  def display_bank_acc_home_menu()
    puts "1: balance"
    puts "2: deposit"
    puts "3: withdraw"
    puts "4: transfer"
    puts "5: exit"
    return read_integer("Enter your choice: ")
  end





end