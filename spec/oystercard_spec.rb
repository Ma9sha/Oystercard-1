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
end