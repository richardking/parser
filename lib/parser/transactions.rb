require 'forwardable'
require_relative 'accounts'
require_relative 'matcher'

class InvalidFileTypeError < StandardError; end

class Transaction < Struct.new(:txn_num, :originator, :recipient, :type, :amount) do
  def valid?
    puts "s"
  end
end

class Transactions
  extend Forwardable
  def_delegators :@transactions, :size, :each, :<<
  include Enumerable

  attr_reader :accounts, :transactions

  def initialize
    @transactions = []
    @accounts = Accounts.new
  end

  def calculate_net
    transactions.each do |txn|
      if txn.type == "Credit"
        txn.originator.debit(txn.amount.to_i)
        txn.recipient.credit(txn.amount.to_i)
      elsif txn.type == "Debit"
        txn.originator.credit(txn.amount.to_i)
        txn.recipient.debit(txn.amount.to_i)
      end
    end
  end

  def read_txn(ary)
    t = Transaction.new
    t.txn_num = Matcher.new(ary).get_value_for("Transaction")
    t.type = Matcher.new(ary).get_value_for("Type")
    t.amount = Matcher.new(ary).get_value_for("Amount")

    originator_account_info = Matcher.new(ary).get_account_numbers("Originator")
    acct = @accounts.find_or_create(*originator_account_info)
    t.originator = acct

    recipient_account_info = Matcher.new(ary).get_account_numbers("Recipient")
    acct = @accounts.find_or_create(*recipient_account_info)
    t.recipient = acct

    puts t.valid?
    puts t.inspect

    @transactions << t
  end
end
