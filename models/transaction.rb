require_relative '../utilities/time'
class Transaction
  attr_accessor :id,:date,:amount,:type
  def initialize(id,sender,recipient,amount,type,date= get_current_time)
    @id = id
    @sender = sender
    @recipient = recipient
    @amount = amount
    @type = type
    @date = date
  end
end