require 'journeylog'
require 'journey'

describe JourneyLog do

  let (:baker_street_dbl) {double("station", name: "Baker Street")}
  let (:bank_dbl) {double("station", name: "Bank")}
  subject {JourneyLog.new}

  it '#start(station)' do
    subject.start(baker_street_dbl)
    expect(subject.current_journey.entry_station.name).to eq('Baker Street')
  end

  it '#start(station)' do
    subject.start(baker_street_dbl)
    expect(subject.current_journey.exit_station).to eq(nil)
  end
end