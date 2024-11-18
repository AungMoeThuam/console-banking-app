require_relative "../views/main_menu"
require_relative '../controllers/user_controller'
require_relative '../utilities/message_functions'
require_relative '../constants/user_role'
require_relative '../views/customer_menus'
require_relative '../views/home_menus'

class App_Controller
  def initialize
    @user_controller = User_Controller.new
  end
  def run_app()
    while true
      choice = display_main_menu()
      case choice
      when 1
        self.login_screen()
      when 2
        new_registration = display_register_menu()
      else
        break
      end
    end
  end

  def login_screen
    login_credential = display_login_menu()
    auth = @user_controller.login(login_credential)
    if auth == nil
      login_failed_message()
      return
    end
    current_user = @user_controller.current_user

    case current_user.role
    when User_Role::ADMIN
      puts "it is an admin"
    when User_Role::MANAGER
      puts "it is an manager"
    when User_Role::CUSTOMER
      customer_home_screen()
    end
  end

  def customer_home_screen()
    choice = display_customer_home_menu()
    if choice == 1 || choice == 2 || choice == 3
      choice = display_bank_acc_home_menu()
      savings_acc = @user_controller.current_user.accounts[0]
      case choice
      when 1
        savings_acc.display_balance
      when 2
        deposit_amount = read_integer("Enter deposit amount: ")
        savings_acc.deposit(deposit_amount)
      when 3
        withdraw_amount = read_integer("Enter withdraw amount: ")
        savings_acc.withdraw(withdraw_amount)
      when 4
        recipient_acc_no = read_integer("Enter recipient acc no: ")
        amount = read_integer("Enter amount to transfer: ")
        status = @user_controller.transfer_money(savings_acc,recipient_acc_no,amount)
      end

    else

    end
  end
end




