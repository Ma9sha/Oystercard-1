require 'oystercard'
describe Oystercard do
  let (:entry_station_dbl) {double("Entry_station", name: "Baker Street")}
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
      set_card_use_state(true)
      expect{subject.touch_out}.to change{subject.balance}.by(-200)
    end
    it '#touch_in' do
      subject.touch_in(entry_station_dbl)
      expect(subject.in_journey?).to eq(true)
    end
    it '#touch_in(entry_station)' do
      subject.touch_in(entry_station_dbl)
      expect(subject.entry_station).to eq("Baker Street")
    end
  end

  it '#in_journey?' do
    expect(subject.in_journey?).to eq(false)
  end
  it '#touch_out' do
    set_card_use_state(true)
    subject.touch_out
    expect(subject.in_journey?).to eq(false)
  end

  context '#balance=99' do
    it '#touch_in' do
      expect{subject.touch_in(entry_station_dbl)}.to raise_error("Minimum fare of £1 is required to touch in")
    end
  end

  def set_card_use_state(state)
    subject.instance_variable_set(:@in_use, state)
  end
end