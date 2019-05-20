class Oystercard
  MAXIMUM_BALANCE = 9000
  attr_reader :balance
  def initialize(balance=0)
    @balance = balance
    @in_use = false
  end

  def top_up(amount)
    if @balance + amount > 9000
      raise "Maximum limit (of £#{MAXIMUM_BALANCE/100}) reached"
    else 
      @balance += amount
    end
  end

  def deduct(amount)
    @balance -= amount
  end
  def in_journey?
    @in_use
  end
  def touch_in
    @in_use = true
  end
  def touch_out
    @in_use = false
  end
end