require_relative '../utilities/time'
class Loan
  attr_reader :amount, :date,:is_approved, :account_no
  def initialize(amount)
    @amount = amount
    @is_approved = false
    @date = get_current_time
  end

  def withdraw(amount)
    @amount -= amount
  end

  def set_date(date)
    @date = date
  end

  def set_amount(amount)
    @amount = amount
  end

  def set_is_approved(is_approved)
    @is_approved = is_approved
  end

  def to_hash
    hash = { "amount" => @amount, "date" => @date, "is_approved" => @is_approved }
    return hash
  end

end