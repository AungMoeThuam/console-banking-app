require_relative '../constants/user_role'
require_relative '../utilities/generate_unique_id'
require "json"

#parent class
class User
  attr_reader :account_no, :name, :email, :password, :role

  def initialize(name, email, password)
    @account_no = generate_unique_id
    @name = name
    @email = email
    @password = password
  end

  def to_hash
    { "name" => @name, "email" => @email, "account_no" => @account_no, "password" => @password, "role" => @role }
  end
end

class Admin < User
  attr_accessor :role

  def initialize(name, email, password)
    super(name, email, password)
    @role = User_Role::ADMIN
  end

end

class Manager < User
  attr_reader :role, :is_activated

  def initialize(name, email, password)
    super(name, email, password)
    @role = User_Role::MANAGER
    @is_activated = false
  end

  def set_is_activated(activation)
    @is_activated = activation
  end

  def to_hash
    { "name" => @name, "email" => @email, "account_no" => @account_no, "password" => @password, "role" => @role, "is_activated" => @is_activated }
  end
end

class Customer < User
  attr_reader :account_no, :transactions, :balance, :role, :is_activated, :loan

  def initialize(name, email, password, balance)
    super(name, email, password)
    @role = User_Role::CUSTOMER
    @transactions = []
    @is_activated = false
    @balance = balance
    @loan = nil
  end

  def set_loan(loan)
    @loan = loan
  end

  def set_role(role)
    @role = role
  end

  def set_is_activated(activation)
    @is_activated = activation
  end

  def set_account_no(account_no)
    @account_no = account_no
  end

  def add_transaction(transaction)
    @transactions.push(transaction)
  end

  def deposit(amount)
    @balance += amount
    true
  end

  def withdraw(amount)
    if @balance >= amount
      @balance -= amount
      true
    else
      false
    end
  end

  def to_hash
    transactions = []
    loan = !@loan ? nil : @loan.to_hash # convert loan to hash
    if @transactions.length > 0
      i = 0
      while i < @transactions.length
        transactions.push(@transactions[i].to_hash) # convert each transaction to hash
        i += 1
      end
    end
    { "name" => @name, "email" => @email, "password" => @password, "account_no" => @account_no, "role" => @role, "is_activated" => @is_activated, "balance" => @balance, "loan" => loan, "transactions" => transactions }
  end
end