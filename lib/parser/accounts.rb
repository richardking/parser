require 'forwardable'

class Account
  attr_reader :routing_num, :account_num, :net_txns

  def initialize(routing_num, account_num)
    @routing_num = routing_num
    @account_num = account_num
    @net_txns = 0
  end

  def credit(amount)
    @net_txns += amount
  end

  def debit(amount)
    @net_txns -= amount
  end
end

class Accounts
  extend Forwardable
  def_delegators :@accounts, :size, :each, :<<
  include Enumerable
  attr_reader :accounts

  def initialize
    @accounts = []
  end

  def find(routing_num, account_num)
    @accounts.select {|act| act.routing_num == routing_num && act.account_num == account_num }
  end

  def find_or_create(routing_num, account_num)
    results = find(routing_num, account_num)
    if results.empty?
      new_acct = Account.new(routing_num, account_num)
      @accounts << new_acct
      new_acct
    else
      results.first
    end
  end
end
