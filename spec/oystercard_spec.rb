require 'oystercard'
require 'journey'
describe Oystercard do
  let (:baker_street_dbl) {double("station", name: "Baker Street")}
  let (:bank_dbl) {double("station", name: "Bank")}
  MINIMUM_FARE = -Journey::MINIMUM_FARE
  subject { Oystercard.new }
  it '#balance == 0' do
    expect(subject.balance).to eq(0)
  end

  it '#top_up(1000)' do
    expect{subject.top_up(1000)}.to change{subject.balance}.by(1000)
  end

  let(:maximum) {Oystercard::MAXIMUM_BALANCE}
  it '#top_up(10000)' do
    expect{subject.top_up(maximum+1)}.to raise_error("Maximum limit (of £#{maximum/100}) reached")
  end

  context '#balance=3000' do
    before {subject.top_up(3000)}
    it '#touch_out' do
      subject.touch_in(baker_street_dbl)
      expect{subject.touch_out(bank_dbl)}.to change{subject.balance}.by(MINIMUM_FARE)
    end
    it 'touch_out' do
      subject.touch_in(baker_street_dbl)
      subject.touch_out(bank_dbl)
      expect(subject.entry_station).to eq(nil)
    end
    it '#touch_in' do
      subject.touch_in(baker_street_dbl)
      expect(subject.in_journey?).to eq(true)
    end
    it '#touch_in(entry_station)' do
      subject.touch_in(baker_street_dbl)
      expect(subject.entry_station).to eq("Baker Street")
    end
    it '#touch_in + #touch_out -> station history' do
      subject.touch_in(baker_street_dbl)
      subject.touch_out(bank_dbl)
      journey = subject.history.last
      expect(journey.entry_station).to eq('Baker Street')
    end
    it '#touch_out' do
      subject.touch_in(baker_street_dbl)
      subject.touch_out(bank_dbl)
      expect(subject.in_journey?).to eq(false)
    end
  end

  it '#in_journey?' do
    expect(subject.in_journey?).to eq(false)
  end

  context '#balance=99' do
    it '#touch_in' do
      expect{subject.touch_in(baker_street_dbl)}.to raise_error("Minimum fare of £1 is required to touch in")
    end
  end
end