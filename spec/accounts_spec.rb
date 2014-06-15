require 'helper'

describe Accounts do
  let(:accounts) do
    accounts = Accounts.new
    @acct1 = Account.new(1, 2)
    @acct2 = Account.new(1, 3)
    @acct3 = Account.new(2, 4)
    accounts << @acct1
    accounts << @acct2
    accounts << @acct3
    accounts
  end

  it 'should return the number of accounts' do
    expect(accounts.size).to eq(3)
  end

  it 'should find an account' do
    expect(accounts.find(1,2)).to eq([@acct1])
  end

  it 'should find an account (find_or_create)' do
    expect(accounts.find_or_create(1,2)).to eq(@acct1)
  end

  it 'should create an account' do
    expect{accounts.find_or_create(3,2)}.to change{accounts.size}.by(1)
  end
end
