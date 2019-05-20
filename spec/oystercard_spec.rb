require 'oystercard'
describe Oystercard do
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
    it '#deduct(200)' do
      subject.top_up(3000)
      expect{subject.deduct(200)}.to change{subject.balance}.by(-200)
    end
  end

  it '#in_journey?' do
    expect(subject.in_journey?).to eq(false)
  end
  it '#touch_in' do
    subject.touch_in
    expect(subject.in_journey?).to eq(true)
  end
  it '#touch_out' do
    subject.instance_variable_set(:@in_use, true)
    subject.touch_out
    expect(subject.in_journey?).to eq(false)
  end
end