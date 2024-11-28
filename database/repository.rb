require_relative '../database/file_system'
require_relative '../models/user'
require_relative '../constants/user_role'
require_relative '../constants/transaction_type'
require_relative '../models/transaction'

class Repository
  def initialize
    @file = FileSystem.new
  end

  def get_loan_users
    users = @file.read_users
    loan_users = []
    i = 0
    while i < users.length
      user = users[i]
      i += 1
      if user["role"] == User_Role::ADMIN || user["role"] == User_Role::MANAGER # if user is manager or admin, skip not need to check
        next
      end

      if user["loan"]
        loan_user = serialize(user)
        loan_users.push(loan_user)
      end
    end

    loan_users # users who applied loans
  end

  def is_email_exist(email, role = User_Role::CUSTOMER)
    users = @file.read_users
    i = 0
    while i < users.length
      if email == users[i]["email"] && role == users[i]["role"]
        return true # found
      end
      i += 1
    end
    false # not found
  end

  def get_unactivated_users
    users = @file.read_users
    unactivated_users = []
    i = 0
    while i < users.length
      if  users[i]["is_activated"] == false
        user = serialize(users[i])
        unactivated_users.push(user)
      end
      i += 1
    end
    unactivated_users
  end

  def serialize(raw_user)
    #this function is to convert user hash to records

    user = nil
    case raw_user["role"]

    when User_Role::ADMIN
      user = Admin.new(raw_user["name"], raw_user["email"], raw_user["password"])
    when User_Role::MANAGER
      user = Manager.new(raw_user["name"], raw_user["email"], raw_user["password"])
      user.set_is_activated(raw_user["is_activated"])
    else
      user = Customer.new(raw_user["name"], raw_user["email"], raw_user["password"], raw_user["balance"].to_f)

      user.set_account_no(raw_user["account_no"])
      user.set_is_activated(raw_user["is_activated"])
      if raw_user["loan"]
        loan = Loan.new(raw_user["loan"]["amount"])
        loan.set_date(raw_user["loan"]["date"])
        loan.set_is_approved(raw_user["loan"]["is_approved"])
        user.set_loan(loan)
      end

      if raw_user["transactions"].length > 0
        i = 0
        while i < raw_user["transactions"].length
          raw_transaction = raw_user["transactions"][i]
          transaction = nil
          case raw_transaction["type"]
          when Transaction_Type::DEPOSIT
            transaction = Transaction.deposit(raw_transaction["account_no"], raw_transaction["amount"])
          when Transaction_Type::WITHDRAWAL
            transaction = Transaction.withdraw(raw_transaction["account_no"], raw_transaction["amount"])
          when Transaction_Type::TRANSFER
            transaction = Transaction.transfer(raw_transaction["sender"], raw_transaction["recipient"], raw_transaction["amount"])
          end
          transaction.set_id(raw_transaction["id"])
          transaction.set_date(raw_transaction["date"])
          user.add_transaction(transaction)
          i += 1
        end
      end
    end
    user
  end

  def find_user_by_login(user)
    users = @file.read_users
    i = 0
    while i < users.length
      if user["email"] == users[i]["email"] && user["password"] == users[i]["password"]
        user = serialize(users[i])
        return user # found user
      end
      i += 1
    end
    nil # not found
  end

  def find_user_by_account_no(account_no)
    users = @file.read_users
    i = 0
    while i < users.length
      if account_no == users[i]["account_no"]
        user = serialize(users[i])
        return user # found user
      end
      i += 1
    end
    nil # not found
  end

  def update_user(user)
    users = @file.read_users
    i = 0
    while i < users.length
      if user.account_no == users[i]["account_no"]
        users[i] = user.to_hash
      end
      i += 1
    end
    @file.write_users(users) # write data to disk
  end

  def insert_user(user)
    users = @file.read_users
    users.push(user.to_hash)
    @file.write_users(users) # write data to disk
  end
end

