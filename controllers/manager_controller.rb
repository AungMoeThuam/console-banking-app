require_relative '../models/user'
require_relative '../database/repository'
require_relative '../views/manager_view'

class ManagerController

  def initialize(manager)
    @manager = manager
    @manager_view = ManagerView.new(@manager)
    @repository = Repository.new
  end

  def start
    while true
      menu = @manager_view.display_home_menu
      case menu
      when 1
        check_user_transactions
      when 2
        check_user_account_info
      when 5
        return
      else
        @manager_view.display_invalid_choice_message
      end
    end
  end

  def check_user_transactions
    user_account_no = @manager_view.display_asking_user_acc_number_menu
    if user_account_no == "0"
      return
    end

    user = @repository.find_user_by_account_no(user_account_no)

    if !user
      @manager_view.display_user_not_found_message(user_account_no)
      return
    end
    if user.role == User_Role::ADMIN || user.role == User_Role::MANAGER
      @manager_view.display_user_not_found_message(user_account_no)
      return
    end
    @manager_view.display_transactions(user)

  end

  def check_user_account_info
    user_account_no = @manager_view.display_asking_user_acc_number_menu
    if user_account_no == "0"
      return
    end

    user = @repository.find_user_by_account_no(user_account_no)

    if !user
      @manager_view.display_user_not_found_message(user_account_no)
      return
    end
    if user.role == User_Role::ADMIN || user.role == User_Role::MANAGER
      @manager_view.display_user_not_found_message(user_account_no)
      return
    end

    @manager_view.display_customer_info(user)

  end

end

