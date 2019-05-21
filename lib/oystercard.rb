class Oystercard
  MAXIMUM_BALANCE = 9000
  MINIMUM_BALANCE = 100
  attr_reader :balance, :entry_station, :history
  def initialize(balance=0)
    @balance = balance
    @entry_station
    @exit_station
    @history = []
  end

  def top_up(amount)
    if @balance + amount > MAXIMUM_BALANCE
      raise "Maximum limit (of £#{MAXIMUM_BALANCE/100}) reached"
    else 
      @balance += amount
    end
  end
  def in_journey?
    !@entry_station.nil?
  end
  def touch_in(station)
    if minimum_balance_met?
      @in_use = true
      @entry_station = station_name(station)
    else
      raise "Minimum fare of £1 is required to touch in"
    end
  end
  def touch_out(station)
    this_journey_cost = 200
    deduct(this_journey_cost)
    @exit_station = station_name(station)
    make_histry
    @entry_station = nil
  end
  def make_histry
    journey = {entry_station: @entry_station, exit_station: @exit_station}
    @history.push(journey)
  end
  def minimum_balance_met?
    @balance >= MINIMUM_BALANCE
  end
  private
  def station_name(station)
    station.name
  end
  def deduct(amount)
    @balance -= amount
  end
end