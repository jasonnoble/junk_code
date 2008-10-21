#!/usr/local/bin/ruby

require "pty"
require "expect"

STDOUT.sync = true
STDERR.sync = true
$expect_verbose = true

PTY.spawn("./checkout.rb") { |stdin, stdout, pid|
  begin
    stdin.expect("Enter skus (name quantity price), one per line, enter blank line to continue")
    stdout.puts "a 1 0.5"
    stdin.expect "Adding a 1 0.50"
    stdout.puts ""
    stdin.expect "Enter products to purchase, one per line, enter blank line to continue"
    stdout.puts "a"
    stdout.puts ""
    stdin.expect "TOTAL $0.50"

  end
}
