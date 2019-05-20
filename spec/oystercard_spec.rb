require 'oystercard'
describe Oystercard do
  subject { Oystercard.new }
  it '#balance == 0' do
    expect(subject.balance).to eq(0)
  end

  it '#top_up(1000)' do
    subject.top_up(1000)
    expect(subject.balance).to eq(1000)
  end

  let(:maximum) {Oystercard::MAXIMUM_BALANCE}
  it '#top_up(10000)' do
    expect{subject.top_up(maximum+1)}.to raise_error("Maximum limit (of £#{maximum/100}) reached")
  end

  context '#balance=3000' do
    before {subject.top_up(3000)}
    it '#deduct(200)' do
      subject.deduct(200)
      expect(subject.balance).to eq (2800)
    end
    it '#touch_in' do
      subject.touch_in
      expect(subject.in_journey?).to eq(true)
    end
  end

  it '#in_journey?' do
    expect(subject.in_journey?).to eq(false)
  end
  it '#touch_out' do
    subject.instance_variable_set(:@in_use, true)
    subject.touch_out
    expect(subject.in_journey?).to eq(false)
  end

  context '#balance=99' do
    it '#touch_in' do
      expect{subject.touch_in}.to raise_error("Minimum fare of £1 is required to touch in")
    end
  end
end