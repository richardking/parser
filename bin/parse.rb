#!/usr/bin/env ruby

require_relative '../lib/parser'

puts Parser.new(ARGV.first).build_json
