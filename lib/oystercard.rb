class Oystercard
  MAXIMUM_BALANCE = 9000
  MINIMUM_BALANCE = 100
  attr_reader :balance
  def initialize(balance=0)
    @balance = balance
    @in_use = false
  end

  def top_up(amount)
    if @balance + amount > MAXIMUM_BALANCE
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
    if minimum_balance_met?
      @in_use = true
    else
      raise "Minimum fare of £1 is required to touch in"
    end
  end
  def touch_out
    @in_use = false
  end
  def minimum_balance_met?
    @balance >= MINIMUM_BALANCE
  end
end