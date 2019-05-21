class Journey
  FINE_FARE = 600
  MINIMUM_FARE = 100
  attr_accessor :entry_station, :exit_station
  def initialize
    @entry_station = nil
    @exit_station = nil
  end
  def calculate_cost
    if @entry_station.nil? || @exit_station.nil?
      FINE_FARE
    else
      MINIMUM_FARE
    end
  end
end