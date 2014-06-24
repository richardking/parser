require 'helper'

def net_transactions_for(accounts, routing_number, account_number)
  accounts.select{|a| a['routing_number'] == routing_number && a['account_number'] == account_number }.first['net_transactions']
end

describe Parser do
  subject { JSON.parse(Parser.new('spec/fixtures/valid_data.bdi').build_json) }

  its(['batch']) { should eq('99') }
  its(['description']) { should eq('Payroll for January') }
  its('size') { should eq(3) }

  context 'account net balances' do
    let(:accounts_info) { JSON.parse(Parser.new('spec/fixtures/valid_data.bdi').build_json)['accounts'] }

    it 'should calculate the correct balance for acct 1' do
      expect(net_transactions_for(accounts_info, '111222333', '9991')).to eq(-390100)
    end

    it 'should calculate the correct balance for acct 2' do
      expect(net_transactions_for(accounts_info, '123456789', '55550')).to eq(380100)
    end
  end

  context 'invalid file type' do
    it 'should raise error' do
      expect{Parser.new('spec/fixtures/invalid_file_type.bdi').build_json}.to raise_error(InvalidFileTypeError)
    end
  end
end
