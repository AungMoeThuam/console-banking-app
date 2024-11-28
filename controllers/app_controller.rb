require_relative '../controllers/customer_controller'
require_relative '../controllers/admin_controller'
require_relative '../controllers/manager_controller'
require_relative '../utilities/center_text'
require_relative '../constants/user_role'
require_relative '../views/app_view'
require_relative '../database/repository'

class AppController
  def initialize
    @user_repository = Repository.new
    @app_view = AppView.new
  end

  def run_app
    while true
      choice = @app_view.display_home_menu
      case choice
      when 1
        login
      when 2
        register
      when 3
        break
      else
        puts "wrong choice! try again!"
      end
    end
  end

  def login
    login_credential = @app_view.display_login_menu
    user = @user_repository.find_user_by_login(login_credential)
    if !user
      @app_view.display_invalid_login_message
      return
    end
    if user.role != User_Role::ADMIN && !user.is_activated
      @app_view.display_unactivated_account_message
      return
    end
    user_controller = nil
    case user.role
    when User_Role::ADMIN
      user_controller = AdminController.new(user)
    when User_Role::MANAGER
      user_controller = ManagerController.new(user)
    else
      user_controller = CustomerController.new(user)
    end
    user_controller.start
  end

  def register
    register_credential = @app_view.display_register_menu
    if_user_exist = @user_repository.is_email_exist(register_credential["email"])
    if if_user_exist
      @app_view.display_user_already_exist_message
      return
    end
    new_user = Customer.new(register_credential["name"], register_credential["email"], register_credential["password"], 0.0)
    @user_repository.insert_user(new_user)
    @app_view.display_register_success_message

  end

end





