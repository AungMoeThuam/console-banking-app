class AppView
  def initialize

  end

  def display_home_menu
    border_text("AM Banking App")
    center_text("Welcome"," ")
    puts "1: login"
    puts "2: register"
    puts "3: exit"
    choice = read_integer("enter your choice: ")
    return choice
  end
end