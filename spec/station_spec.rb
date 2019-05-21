require 'station'

describe Station do

  it 'station name' do
    station = Station.new("Stratford", 1)
    expect(station.name).to eq("Stratford")
  end

  it 'station zone' do
    station = Station.new("Stratford", 1)
    expect(station.zone).to eq(1)
  end

end
