require 'helper'

describe Transactions do
  subject do
    txn = IO.read("spec/fixtures/single_transaction.bdi").split("\n")
    transactions = Transactions.new.read_txn(txn)
    transactions.first
  end

  its(["txn_num"]) { should eq("301") }
  its(["type"]) { should eq("Credit") }
  its(["amount"]) { should eq("10000") }
end
