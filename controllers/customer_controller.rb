require_relative '../models/user'
require_relative '../models/loan'
require_relative '../database/repository'
require_relative '../views/customer_view'

class CustomerController

  def initialize(customer)
    @customer = customer
    @customer_view = CustomerView.new(@customer)
    @repository = Repository.new
  end

  def start
    while true
      menu = @customer_view.display_home_menu
      case menu
      when 1
        deposit
      when 2
        withdraw
      when 3
        transfer
      when 4
        loan
      when 5
        transactions_history
      when 6
        return
      when 7
        refresh
      else
        @customer_view.display_invalid_choice_message
      end
    end
  end

  def refresh
    @customer = @repository.find_user_by_account_no(@customer.account_no)
    @customer_view = CustomerView.new(@customer)
  end

  def deposit
    deposit_amount = @customer_view.display_deposit_menu
    if deposit_amount == 0
      return
    end
    @customer.deposit(deposit_amount)
    transaction = Transaction.deposit(@customer.account_no, deposit_amount)
    @customer.add_transaction(transaction)
    @repository.update_user(@customer)
    @customer_view.display_deposit_success_message(deposit_amount)
  end

  def withdraw
    withdraw_amount = @customer_view.display_withdraw_menu
    if withdraw_amount == 0
      return
    end
    status = @customer.withdraw(withdraw_amount)
    if !status
      @customer_view.display_not_enough_balance_message
      return
    end
    transaction = Transaction.withdraw(@customer.account_no, withdraw_amount)
    @customer.add_transaction(transaction)
    @repository.update_user(@customer)
    @customer_view.display_withdraw_success_message(withdraw_amount)
  end

  def transfer
    transfer = @customer_view.display_transfer_menu
    transfer_amount = transfer["amount"]
    recipient_no = transfer["recipient_no"]
    if transfer_amount == 0 || recipient_no == "0"
      return
    end

    if recipient_no == @customer.account_no
      @customer_view.display_transfer_to_self_warning_message
      return
    end
    recipient_user = @repository.find_user_by_account_no(recipient_no)
    if !recipient_user
      @customer_view.display_user_not_found_message(recipient_no)
      return
    end

    status = @customer.withdraw(transfer_amount)
    if !status
      @customer_view.display_not_enough_balance_message
      return
    end
    recipient_user.deposit(transfer_amount)
    transaction = Transaction.transfer(@customer.account_no, recipient_no, transfer_amount)
    recipient_user.add_transaction(transaction)
    @customer.add_transaction(transaction)
    @repository.update_user(@customer)
    @repository.update_user(recipient_user)
    @customer_view.display_transfer_success_message(transfer_amount, recipient_user.name)
  end

  def transactions_history
    @customer_view.display_transactions(@customer)
  end

  def loan
    menu = @customer_view.display_loan_menu
    case menu
    when 1
      @customer_view.display_check_loan_menu
    when 2
      apply_loan
    when 3
      repay_loan
    when 4
      return
    else
      @customer_view.display_invalid_choice_message
    end
  end

  def repay_loan
    loan_repay_amount = @customer_view.display_repay_loan_menu
    if loan_repay_amount == 0
      return
    end

    if !@customer.loan
      @customer_view.display_no_active_loan_message
      return
    end

    if loan_repay_amount > @customer.loan.amount
      @customer_view.display_loan_repay_amount_exceed_message
      return
    end

    status = @customer.withdraw(loan_repay_amount)
    if !status
      @customer_view.display_not_enough_balance_message
      return
    end

    @customer.loan.withdraw(loan_repay_amount)

    if @customer.loan.amount == 0
      @customer.set_loan(nil)
    end
    @repository.update_user(@customer)
    @customer_view.display_loan_repay_success_message(loan_repay_amount)

  end

  def apply_loan
    loan_amount = @customer_view.display_apply_loan_menu
    if loan_amount == 0
      return
    end

    if @customer.loan
      @customer_view.display_loan_not_eligible_message
      return
    end

    new_loan = Loan.new(loan_amount)
    @customer.set_loan(new_loan)
    @repository.update_user(@customer)
    @customer_view.display_apply_loan_success_message
  end
end

