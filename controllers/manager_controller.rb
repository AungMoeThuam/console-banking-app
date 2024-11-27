require_relative '../database/database'
require_relative '../models/user'
require_relative '../repository/user_repository'
require_relative '../views/manager_view'
require "json"

class ManagerController

  def initialize(user)
    @user = user
    @manager_view = ManagerView.new(@user)
    @user_repository = UserRepository.new
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
      end
    end
  end

  def check_user_transactions
    user_account_no = @manager_view.display_checking_transactions_menu
    if user_account_no == "0"
      return
    end

    user = @user_repository.find_user_by_account_no(user_account_no)

    if !user
      puts "There is no user with account no #{user_account_no}"
      return
    end
    @manager_view.display_transactions(user)

  end

  def check_user_account_info
    user_account_no = @manager_view.display_checking_customer_info_menu
    if user_account_no == "0"
      return
    end

    user = @user_repository.find_user_by_account_no(user_account_no)

    if !user
      puts "There is no user with account no #{user_account_no}"
      return
    end

    @manager_view.display_customer_info(user)

  end






end

