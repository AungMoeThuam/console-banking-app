require_relative '../database/database'
require_relative '../models/user'
require_relative '../repository/user_repository'
require_relative '../views/customer_view'
require "json"

class CustomerController
  attr_accessor :users, :current_user

  def initialize(user)
    @user = user
    @user_view = CustomerView.new(@user)
    @user_repository = UserRepository.new
  end


  def start
    while true
      menu = @user_view.display_home_menu
      case menu
        when 1
          deposit
        when 2
          withdraw
        when 3
          transfer
        when 5
          transactions_history
        when 6
          return
      end
    end
  end

  def deposit
    deposit_amount = @user_view.display_deposit_menu
    if deposit_amount == 0
      return
    end
    @user.deposit(deposit_amount)
    transaction = Transaction.deposit(@user.account_no,deposit_amount)
    @user.add_transaction(transaction)
    @user_repository.update_user(@user)
    puts "RM #{deposit_amount} has been deposited to your account!"
    puts "press enter to continue..."
    gets
  end

  def withdraw
    withdraw_amount = @user_view.display_withdraw_menu
    if withdraw_amount == 0
      return
    end
    status = @user.withdraw(withdraw_amount)
    if !status
      puts "No enough balance!"
      puts "press enter to continue..."
      gets
      return
    end
    transaction = Transaction.withdraw(@user.account_no,withdraw_amount)
    @user.add_transaction(transaction)
    @user_repository.update_user(@user)
    puts "Rm #{withdraw_amount} has been withdrawn from your account!"
    puts "press enter to continue..."
    gets
  end

  def transfer
    transfer = @user_view.display_transfer_menu
    transfer_amount = transfer["amount"]
    recipient_no = transfer["recipient_no"]
    if transfer_amount == 0 || recipient_no == "0"
      return
    end
    recipient_user = @user_repository.find_user_by_account_no(recipient_no)
    if !recipient_user
      puts "No Such Account Number found!"
      puts "press enter to continue..."
      gets
      return
    end

    status = @user.withdraw(transfer_amount)
    if !status
      puts "No enough balance to transfer!"
      puts "press enter to continue..."
      gets
      return
    end
    recipient_user.deposit(transfer_amount)
    transaction = Transaction.transfer(@user.account_no,recipient_no,transfer_amount)
    recipient_user.add_transaction(transaction)
    @user.add_transaction(transaction)
    @user_repository.update_user(@user)
    @user_repository.update_user(recipient_user)
    puts "You have transferred RM #{transfer_amount} to  #{recipient_user.name}"
    puts "press enter to continue..."
    gets
  end

  def transactions_history
    @user_view.display_transactions(@user)
  end




end

