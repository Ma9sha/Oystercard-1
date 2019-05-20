class Oystercard
  MAXIMUM_BALANCE = 9000
  attr_reader :balance
  def initialize(balance=0)
    @balance = balance
  end

  def top_up(amount)
    if @balance + amount > 9000
      raise "Maximum limit (of £#{MAXIMUM_BALANCE/100}) reached"
    else 
      @balance += amount
    end
  end
end