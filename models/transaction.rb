require_relative '../utilities/time'
require_relative '../utilities/generate_unique_id'
require_relative '../constants/transaction_type'
class Transaction
  attr_reader :id, :date, :amount, :type, :account_no

  def initialize(type, amount, account_no = nil, sender = nil, recipient = nil)
    @id = generate_unique_id
    @date = get_current_time
    @amount = amount
    @type = type
    @account_no = account_no
    @sender = sender
    @recipient = recipient
  end

  def set_id(id)
    @id = id
  end

  def set_date(date)
    @date = date
  end

  # Factory methods to create different types of transactions
  def self.deposit(account_no, amount)
    Transaction.new(Transaction_Type::DEPOSIT, amount, account_no)
  end

  def self.withdraw(account_no, amount)
    Transaction.new(Transaction_Type::WITHDRAWAL, amount, account_no)
  end

  def self.transfer(sender_account_no, recipient_account_no, amount)
    Transaction.new(Transaction_Type::TRANSFER, amount, sender_account_no, sender_account_no, recipient_account_no)
  end

  # Custom getter for sender, raises an error for non-transfer transactions
  def sender
    raise "Sender is not available for #{@type} transactions" unless @type == Transaction_Type::TRANSFER
    @sender
  end

  # Custom getter for recipient, raises an error for non-transfer transactions
  def recipient
    raise "Recipient is not available for #{@type} transactions" unless @type == Transaction_Type::TRANSFER
    @recipient
  end

  def to_hash
    hash = nil
    case @type
    when Transaction_Type::TRANSFER
      hash = { "id" => @id, "date" => @date, "amount" => @amount, "sender"=>@sender,"recipient" => @recipient,"type" => @type }
    when Transaction_Type::WITHDRAWAL
      hash = { "id" => @id, "date" => @date, "amount" => @amount, "account_no"=>@account_no,"type" => @type }
    when Transaction_Type::DEPOSIT
      hash = { "id" => @id, "date" => @date, "amount" => @amount, "account_no"=>@account_no,"type" => @type }
    end
    hash
  end
end