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
end