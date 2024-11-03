class Acount
  attr_accessor :accountNumber, :type, :balance, :transactions
  def initialize(accountNumber, type, balance, transactions=[])
    @accountNumber = accountNumber
    @type = type
    @balance = balance
    @transactions = transactions
  end
end