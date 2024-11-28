require_relative './controllers/app_controller'

def main
  app_controller = AppController.new
  app_controller.run_app
end
main

