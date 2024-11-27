require_relative '../views/admin_view'
require_relative '../repository/user_repository'
require_relative '../constants/user_role'
require_relative '../utilities/input_functions'

class AdminController

  def initialize(user)
    @user = user
    @admin_view = AdminView.new(@user)
    @user_repository = UserRepository.new
  end

  def start
    while true
      menu = @admin_view.display_home_menu
      case menu
      when 1
        change_password
      when 2
        user_account_activation
      when 3
        register_new_manager
      when 4
        check_user_transactions
      when 5
        check_user_account_info
      when 6
        return
      end
    end
  end

  def user_account_activation
    activation_option = @admin_view.display_activation_option_menu
    case activation_option
    when 1
      activate_user
    when 2
      deactivate_user
    when 3
      return
    end

  end

  def activate_user
    account_no = @admin_view.display_asking_user_info_menu
    if account_no == "0"
      return
    end
    user = @user_repository.find_user_by_account_no(account_no)

    if !user
      puts "User not found!"
      read_string("Press enter to continue...")
      return
    end

    @admin_view.display_user_info(user)
    confirm = @admin_view.display_activate_confirm_menu
    if confirm == 1
      user.set_is_activated(true)
      @user_repository.update_user(user)
      puts "user with account number #{user.account_no} is activated successfully!"
      read_string("Press enter to continue...")
      return
    end

  end

  def deactivate_user
    account_no = @admin_view.display_asking_user_info_menu
    if account_no == "0"
      return
    end
    user = @user_repository.find_user_by_account_no(account_no)

    if !user
      puts "User not found!"
      read_string("Press enter to continue...")
      return
    end

    @admin_view.display_user_info(user)
    confirm = @admin_view.display_deactivate_confirm_menu
    if confirm == 1
      user.set_is_activated(false)
      @user_repository.update_user(user)
      puts "user with account number #{user.account_no} is deactivated successfully!"
      read_string("Press enter to continue...")
      return
    end

  end
  def change_password

  end
  def check_user_transactions
    user_account_no = @admin_view.display_asking_user_info_menu
    if user_account_no == "0"
      return
    end

    user = @user_repository.find_user_by_account_no(user_account_no)

    if !user
      puts "There is no user with account no #{user_account_no}"
      return
    end
    @admin_view.display_transactions(user)

  end

  def register_new_manager
    new_manager_credential = @admin_view.display_register_new_manager_menu
    is_manager_exist = @user_repository.is_email_exist(new_manager_credential["email"], User_Role::MANAGER)

    if is_manager_exist
      puts "Manager already exist!"
      read_string("Press enter to continue...")
      return
    end

    new_manager = Manager.new(new_manager_credential["name"], new_manager_credential["email"], new_manager_credential["password"])
    @user_repository.insert_user(new_manager)
    puts "Registration successful!"
    read_string("Press enter to continue...")
  end

  def check_user_account_info
    user_account_no = @admin_view.display_asking_user_info_menu
    if user_account_no == "0"
      return
    end

    user = @user_repository.find_user_by_account_no(user_account_no)

    if !user
      puts "There is no user with account no #{user_account_no}"
      return
    end

    @admin_view.display_user_info(user)

  end

end