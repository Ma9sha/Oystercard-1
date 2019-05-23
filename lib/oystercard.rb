require 'journey'
class Oystercard
  MAXIMUM_BALANCE = 9000
  MINIMUM_BALANCE = 100
  attr_reader :balance, :history
  def initialize(balance=0)
    @balance = balance
    
    #@journey = Journey.new
    @journeylog = Journeylog.new

  end

  def top_up(amount)
    if @balance + amount > MAXIMUM_BALANCE
      raise "Maximum limit (of £#{MAXIMUM_BALANCE/100}) reached"
    else 
      @balance += amount
    end
  end



  def touch_in(station)
    complete_journey if in_journey?
    
    if minimum_balance_met?
      @journey.entry_station = station_name(station)
    else
      raise "Minimum fare of £1 is required to touch in"
    end
  end

  def touch_out(station)
    @journey.exit_station = station_name(station)
    complete_journey
  end

  def complete_journey
    cost = @journey.calculate_cost
    deduct(cost)
    make_history
    @journey = Journey.new
  end

  def make_history
    @history.push(@journey)
  end
  def minimum_balance_met?
    @balance >= MINIMUM_BALANCE
  end

  # def entry_station
  #   @journey.entry_station
  # end

  private
  def station_name(station)
    station.name
  end
  def deduct(amount)
    @balance -= amount
  end
end