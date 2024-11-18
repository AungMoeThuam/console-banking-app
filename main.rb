require_relative './controllers/app_controller'
require "json"
def main()1
  app_controller = App_Controller.new
  app_controller.run_app()
end
main()

