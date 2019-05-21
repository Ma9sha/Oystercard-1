require 'journey'
describe Journey do
  let(:journey) {Journey.new}
  let(:bank_dbl) {double("station", name: "Bank")}
  it 'exiting a station' do
    journey.exit_station = bank_dbl
    expect(journey.calculate_cost).to eq(600)
  end
  
end