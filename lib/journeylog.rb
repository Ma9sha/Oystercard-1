require 'journey'


class JourneyLog
attr_reader :journey
  def initialize(journey = Journey.new)
    @history = []
    @journey = journey
  end
  def in_journey?
    !@journey.entry_station.nil?
  end

  def start_journey(entry_station)
    @journey.entry_station = entry_station
  end
end