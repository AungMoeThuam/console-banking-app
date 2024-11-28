require_relative '../views/admin_view'
require_relative '../constants/user_role'
require_relative '../utilities/input_functions'
require_relative '../utilities/add_space'
require_relative '../utilities/time'
require_relative '../database/repository'

class AdminController

  def initialize(admin)
    @admin = admin
    @admin_view = AdminView.new(@admin)
    @repository = Repository.new
  end

  def start
    while true
      menu = @admin_view.display_home_menu
      case menu
      when 1
        user_account_activation
      when 2
        register_new_manager
      when 3
        check_user_transactions
      when 4
        check_user_account_info
      when 5
        user_loan_approval
      when 6
        return
      else
        @admin_view.display_invalid_choice_message
      end
    end
  end

  def user_loan_approval

    loan_users = @repository.get_loan_users
    if loan_users.length == 0
      @admin_view.display_no_loans_exist
      return
    end

    # printing table header
    puts "#{add_space_to_right("Name")}#{add_space_to_right("Account No")}#{add_space_to_right("Amount")}#{add_space_to_right("Date")}#{add_space_to_right("Status")}"
    puts "-" * 115

    # printing table body
    i = 0
    while i < loan_users.length
      print add_space_to_right(loan_users[i].name)
      print add_space_to_right(loan_users[i].account_no)
      print "#{add_space_to_right(loan_users[i].loan.amount)}"
      print add_space_to_right(parse_time(loan_users[i].loan.date))
      print add_space_to_right(loan_users[i].loan.is_approved ? "Approved" : "Processing")
      print "\n"
      i += 1
    end

    account_no = @admin_view.display_asking_user_acc_number_menu
    if account_no == "0"
      return
    end

    user = nil
    i = 0
    while i < loan_users.length
      if loan_users[i].account_no == account_no
        user = loan_users[i]
        break
      end
      i += 1
    end

    if !user
      @admin_view.display_user_not_found_message(account_no)
      return
    end

    # display chosen user
    puts "#{add_space_to_right("Name")}#{add_space_to_right("Account No")}#{add_space_to_right("Amount")}"
    print add_space_to_right(user.name)
    print add_space_to_right(user.account_no)
    print add_space_to_right(user.loan.amount)
    print "\n"

    confirm = @admin_view.display_loan_approval_confirm_menu
    if confirm == 0
      return
    end
    interest_rate = 0.1
    total_loan = user.loan.amount + (user.loan.amount * interest_rate)
    user.deposit(user.loan.amount)
    user.loan.set_amount(total_loan)
    user.loan.set_is_approved(true)
    @repository.update_user(user)
    @admin_view.display_approved_loan_message

  end

  def user_account_activation
    un_activated_user = @repository.get_unactivated_users
    @admin_view.display_unactivated_user(un_activated_user)
    account_no = @admin_view.display_asking_user_acc_number_menu
    if account_no == "0"
      return
    end
    user = @repository.find_user_by_account_no(account_no)

    if !user
      @admin_view.display_user_not_found_message(account_no)
      return
    end

    @admin_view.display_user_info(user)
    activation_option = @admin_view.display_activation_option_menu
    if activation_option == 1
      confirm = @admin_view.display_activate_confirm_menu
      if confirm == 1
        user.set_is_activated(true)
        @repository.update_user(user)
        @admin_view.display_activation_success_message(user.account_no)
      else
        return
      end

    elsif activation_option == 2
      confirm = @admin_view.display_deactivate_confirm_menu
      if confirm == 1
        user.set_is_activated(false)
        @repository.update_user(user)
        @admin_view.display_deactivation_success_message(user.account_no)
      else
        return
      end
    end

  end


  def check_user_transactions
    user_account_no = @admin_view.display_asking_user_acc_number_menu
    if user_account_no == "0"
      return
    end

    user = @repository.find_user_by_account_no(user_account_no)

    if !user
      @admin_view.display_user_not_found_message(user_account_no)
      return
    end
    @admin_view.display_transactions(user)

  end

  def register_new_manager
    new_manager_credential = @admin_view.display_register_new_manager_menu
    is_manager_exist = @repository.is_email_exist(new_manager_credential["email"], User_Role::MANAGER)

    if is_manager_exist
      @admin_view.display_manager_already_exist_message
      return
    end

    new_manager = Manager.new(new_manager_credential["name"], new_manager_credential["email"], new_manager_credential["password"])
    @repository.insert_user(new_manager)
    @admin_view.display_manager_register_success_message
  end

  def check_user_account_info
    user_account_no = @admin_view.display_asking_user_acc_number_menu
    if user_account_no == "0"
      return
    end

    user = @repository.find_user_by_account_no(user_account_no)

    if !user
      @admin_view.display_user_not_found_message(user_account_no)
      return
    end

    @admin_view.display_user_info(user)

  end

end