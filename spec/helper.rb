require_relative '../lib/parser'
require 'rspec'
require 'rspec/its'
require 'json'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
