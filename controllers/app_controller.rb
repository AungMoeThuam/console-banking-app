require_relative "../views/main_menu"
require_relative '../controllers/user_controller'
require_relative '../utilities/message_functions'
require_relative '../constants/user_role'
require_relative '../views/customer_menus'
require_relative '../views/home_menus'

class App_Controller
  def initialize
    @user_controller = User_Controller.new
    @app_view = AppView.new
  end
  def run_app()
    @app_view.display_home_menu
  end

end



