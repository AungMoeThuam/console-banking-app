require_relative '../database/database'
require_relative '../models/user'
require_relative '../repository/user_repository'
require "json"

class User_Controller
  attr_accessor :users, :current_user

  def initialize
    @current_user = nil
    @user_repository = UserRepository.new
  end



  def create_user()

  end

  def transfer_money(sender,recipient,amount)
    i = 0
    send_status = false
    receive_status = false
    sender_acc = nil
    recipient_acc = nil
    while i < @users.length
      k = 0
      accounts = @users[i].accounts
      while k < accounts.length
        if accounts[k].account_no == sender
          sender_acc = accounts[k]
          withdraw_status = acc.withdraw(amount)
        elsif accounts[k].account_no == recipient
          recipient_acc = accounts[k]
          deposit_status = acc.deposit(amount)
        end
        k += 1
      end
      i += 1
    end

    if !send_status && !receive_status
      if send_status == false
        recipient_acc.withdraw(amount)
      elsif receive_status == false
        sender_acc.deposit(amount)
      end
      return false
    end

    sender_transaction = Transaction.transfer(sender,recipient,amount)
    recipient_transaction = Transaction.transfer(sender,recipient,amount)
    sender_acc.add_transaction_history(sender_transaction)
    recipient_acc.add_transaction_history(recipient_transaction)

    return true
  end

end

