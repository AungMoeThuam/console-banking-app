require_relative '../database/database'
require_relative '../models/user'
require_relative '../constants/user_role'
require_relative '../constants/transaction_type'
require_relative '../models/transaction'


class UserRepository
  def initialize
    @db = Database.new
  end


  def is_email_exist(email,role=User_Role::CUSTOMER)
    users = @db.read_users
    i = 0
    while i < users.length
      if email == users[i]["email"] && role == users[i]["role"]
        return true
      end
      i += 1
    end
    return false
  end

  def deserialize(user)
    raw_user = user.to_hash
    raw_transaction = []
    if user.transactions.length > 0
      i = 0
      while user.transactions.length > 0
        transaction = user.transactions[i].to_hash
        raw_transaction.push(transaction)
        i += 1
      end
    end
    raw_user["transactions"] = raw_transaction
  end

  def serialize(raw_user)
    user = nil
    case raw_user["role"]
      when User_Role::ADMIN
        user = Admin.new(raw_user["name"], raw_user["email"], raw_user["password"])
      when User_Role::MANAGER
        user = Manager.new(raw_user["name"], raw_user["email"], raw_user["password"])
        user.set_is_activated(raw_user["is_activated"])
      when User_Role::CUSTOMER
        user = Customer.new(raw_user["name"], raw_user["email"], raw_user["password"],raw_user["balance"].to_f)
        user.set_account_no(raw_user["account_no"])
        user.set_is_activated(raw_user["is_activated"])

        if raw_user["transactions"].length > 0
          i = 0
          while i < raw_user["transactions"].length
              raw_transaction = raw_user["transactions"][i]
              transaction = nil
              case raw_transaction["type"]
                when Transaction_Type::DEPOSIT
                  transaction = Transaction.deposit(raw_transaction["account_no"],raw_transaction["amount"])
                when Transaction_Type::WITHDRAWAL
                  transaction = Transaction.withdraw(raw_transaction["account_no"],raw_transaction["amount"])
                when Transaction_Type::TRANSFER
                  transaction = Transaction.transfer(raw_transaction["sender"],raw_transaction["recipient"],raw_transaction["amount"])
              end
              transaction.set_id(raw_transaction["id"])
              user.add_transaction(transaction)
              i += 1
          end
        end
    end
    return user
  end

  def find_user_by_login(user)
    users = @db.read_users
    i = 0
    while i < users.length
      if user["email"] == users[i]["email"] && user["password"] == users[i]["password"]
        user = serialize(users[i])
        return user
      end
      i += 1
    end
    return nil
  end
  def find_user_by_account_no(account_no)
    users = @db.read_users
    i = 0
    while i < users.length
      if account_no == users[i]["account_no"]
        user = serialize(users[i])
        return user
      end
      i += 1
    end
    return nil
  end

  def update_user(user)
    users = @db.read_users
    i = 0
    while i < users.length
      if user.account_no == users[i]["account_no"]
        users[i] = user.to_hash
      end
      i += 1
    end
    @db.write_users(users)
  end

  def insert_user(user)
    users = @db.read_users
    users.push(user.to_hash)
    @db.write_users(users)
  end
end

