require 'jbuilder'
require_relative './parser/transactions'
require_relative './parser/matcher'

class InvalidFileTypeError < StandardError; end
class MissingHeaderInformationError < StandardError; end

class Parser
  attr_reader :file, :batch, :description, :transactions, :path

  def initialize(path)
    @path = path
    @transactions = Transactions.new
  end

  def build_json
    read_file
    parse_file

    Jbuilder.encode do |json|
      json.batch batch
      json.description description

      json.accounts transactions.accounts do |account|
        json.routing_number account.routing_num
        json.account_number account.account_num
        json.net_transactions account.net_txns
      end
    end
  end

  private

  def read_file
    @file = IO.read(path).split("\n")
    raise InvalidFileTypeError unless valid_file_type?
  end

  def parse_file
    parse_header
    transactions.read_txn(next_section) while more_txns?
    transactions.calculate_net
  end

  def more_txns?
    file.index("==")
  end

  def next_section
    file.slice!(0, file.index("==")+1)
  end

  def parse_header
    header = next_section
    @batch = Matcher.new(header).get_value_for("Batch")
    @description = Matcher.new(header).get_value_for("Description")
    raise MissingHeaderInformationError unless batch && description
  end

  def valid_file_type?
    file.first.strip == "/*BDI*/" && file.last.strip == "=="
  end
end
