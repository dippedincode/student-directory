# program that prints its own source code aka a quine
puts File.read(__FILE__)
puts $0  # this prints its own filename