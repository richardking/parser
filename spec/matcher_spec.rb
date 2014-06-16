require 'helper'

describe Matcher do

  let(:matcher) { Matcher.new(['Transaction: 301', 'Originator: 123 / 456', 'Recipient: 234']) }

  it 'should return the transaction number' do
    expect(matcher.get_value_for('Transaction')).to eq('301')
  end

  it 'should return nil for Amount' do
    expect(matcher.get_value_for('Amount')).to be_nil
  end

  it 'should return the originating routing and account numbers' do
    expect(matcher.get_account_numbers('Originator')).to eq(['123', '456'])
  end
end
