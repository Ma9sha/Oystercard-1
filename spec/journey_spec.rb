require 'journey'
describe Journey do
  let(:journey) {Journey.new}
  let(:bank_dbl) {double("station", name: "Bank")}
  let(:baker_street_dbl) {double("station", name: "Baker Street")}

  it 'exiting a station without entry station set' do
    journey.exit_station = bank_dbl
    expect(journey.calculate_cost).to eq(600)
  end

  it "entering a station not finishing journey" do
    journey.entry_station = baker_street_dbl
    expect(journey.calculate_cost).to eq(600)
  end

  it "completed journey" do 
    journey.exit_station = bank_dbl
    journey.entry_station = baker_street_dbl
    expect(journey.calculate_cost).to eq(100)
  end
  
end