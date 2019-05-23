require 'journey'

class JourneyLog
  attr_reader :journey_class, :journey

  def initialize(journey_class = Journey.new)
    @journey_class = journey_class
    @journey = []
    @current_journey
    
  end

  def start(station)
    @current_journey.entry_station = station
  end
  def current_journey
    @current_journey ||= Journey.new
  end

end