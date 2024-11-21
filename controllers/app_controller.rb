require_relative '../controllers/user_controller'
require_relative '../utilities/message_functions'
require_relative '../utilities/center_text'
require_relative '../constants/user_role'
require_relative '../views/app_view'
require_relative '../repository/user_repository'

class App_Controller
  def initialize
    @user_repository = UserRepository.new
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
    login_credential=  @app_view.display_login_menu
    user = @user_repository.find_user(login_credential)
  end

  def register
    register_credential=  @app_view.display_register_menu
    new_user = Customer.new(register_credential["name"], register_credential["email"] ,register_credential["password"])
    @user_repository.insert_user(new_user)

  end

end

app = App_Controller.new
app.run_app



