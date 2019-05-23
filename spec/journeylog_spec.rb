require 'journeylog'
require 'journey'

describe JourneyLog do

  let (:baker_street_dbl) {double("station", name: "Baker Street")}
  let (:bank_dbl) {double("station", name: "Bank")}
  let (:journey_dbl) {double("Journey", :entry_station => "Baker Street")}
  subject {JourneyLog.new}

  it 'should start a journey' do
    #journey log has a start journey method which tells journey class to change entry station to station to the station that oystercard touched in at
    journey = subject.journey
    name = baker_street_dbl.name
    subject.start_journey(name)
    expect(journey.entry_station).to eq("Baker Street")
  end
end