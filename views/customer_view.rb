require_relative '../constants/transaction_type'
require_relative '../utilities/input_functions'
require_relative '../utilities/add_space'
require_relative '../utilities/time'
require_relative '../views/user_view'

class CustomerView < UserView

  def initialize(customer)
    super(customer)
  end

  # menus
  def display_home_menu
    puts ""
    puts "Welcome to #{@user.name}"
    puts "Account No #{@user.account_no}"
    puts "Balance - #{@user.balance}"
    puts "1: deposit"
    puts "2: withdraw"
    puts "3: transfer"
    puts "4: loan"
    puts "5: view transactions history"
    puts "6: exit"
    puts "7: refresh"
    read_integer("Enter your choice: ")
  end

  def display_deposit_menu
    read_float("Enter deposit amount or 0 to exit:  ")
  end

  def display_withdraw_menu
    read_float("Enter withdraw amount or 0 to exit: ")
  end

  def display_loan_menu
    puts ""
    puts "1: check current loan status"
    puts "2: apply loan"
    puts "3: repay loan"
    puts "4: exit"
    read_integer("Enter your choice: ")
  end

  def display_check_loan_menu
    if !@user.loan
      puts "There is no loan you applied or left!"
      read_string("press enter to continue...")
      return
    end

    if !@user.loan.is_approved
      puts "You loan is currently in process!"
      return
    end
    puts "Interest rate is 10%"
    puts "You have loan RM #{@user.loan.amount} to pay"
    read_string("press enter to continue...")
  end

  def display_repay_loan_menu
    read_float("Enter loan amount you want to repay or 0 to exit: ")
  end

  def display_apply_loan_menu
    read_float("Enter loan amount you want to apply or 0 to exit: ")
  end

  def display_confirm_apply_loan_menu(loan_amount)
    read_integer("Are you sure you want to apply #{loan_amount} loan or 0 to exit: ")
  end

  def display_transfer_menu
    puts ""
    recipient = read_string("enter receiver bank account number or 0 to exit: ")
    amount = read_float("enter amount to transfer 0 to exist: ")
    { "recipient_no" => recipient, "amount" => amount }
  end

  # messages

  def display_not_enough_balance_message
    puts "No enough balance!"
    read_string("press enter to continue...")
  end

  def display_transfer_success_message(transfer_amount, recipient_name)
    puts "You have transferred RM #{transfer_amount} to  #{recipient_name}"
    read_string("press enter to continue...")
  end

  def display_withdraw_success_message(withdrawal_amount)
    puts "Rm #{withdrawal_amount} has been withdrawn from your account!"
    read_string("press enter to continue...")
  end

  def display_deposit_success_message(deposit_amount)
    puts "RM #{deposit_amount} has been deposited to your account!"
    read_string("press enter to continue...")

  end

  def display_apply_loan_success_message
    puts "You have applied a new loan to your account!"
    read_string("Press enter to continue...")
  end

  def display_loan_not_eligible_message
    puts "You are not eligible to apply a new loan since you already have ongoing loan! "
    read_string("Press enter to continue...")

  end

  def display_loan_repay_success_message(loan_repay_amount)
    puts "You have repay RM #{loan_repay_amount} for the loan!"
    read_string("Press enter to continue...")
  end

  def display_no_active_loan_message
    puts "You have no active loan to repay!"
    read_string("Press enter to continue...")
  end

  def display_loan_repay_amount_exceed_message
    puts "You repay amount exceed your loan! You dont need to repay amount that exceed than loan"
    read_string("Press enter to continue...")
  end

  def display_transfer_to_self_warning_message
    puts "You cannot transfer back to your account!"
    read_string("Press enter to continue...")
  end

end

