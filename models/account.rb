require_relative './transaction'
require_relative '../constants/transaction_type'
class Account
  attr_accessor :account_no, :type, :balance, :transactions, :is_freeze, :is_active
  def initialize(account_no, type, balance, transactions=[])
    @account_no = account_no
    @type = type
    @balance = balance
    @transactions = transactions
    @is_freeze = false
    @is_active = false
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

  def add_transaction_history(transaction)
    @transactions.push(transaction)
  end

  def display_balance()
    puts "balance - #{@balance}"
  end

end