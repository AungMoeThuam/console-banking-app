require_relative '../database/database'
require_relative '../models/user'
require "json"

class User_Controller
  attr_accessor :users, :current_user

  def initialize
    @users = get_users
    puts @users.inspect
    @current_user = nil
  end
  def get_users()
    data = read_file()
    i = 0
    users = []
    while i < data["users"].length
      user = data["users"][i]
      name = user["name"]
      email = user["email"]
      password = user["password"]
      accounts = user["accounts"]
      role = user["role"]
      users[i] = Customer.new( name,email, password)
      users[i].accounts = accounts
      i += 1
    end
    return users
  end

  def login(login_credential)
    i = 0
    while i < @users.length
      user = @users[i]
      if user.email == login_credential["email"] && user.password == login_credential["password"]
        hash = {"name"=>user.name, accounts: user.accounts}
        @current_user = user
        return hash
      end
      i += 1
    end
    return nil
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

