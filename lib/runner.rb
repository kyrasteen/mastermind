require_relative 'messages'
require_relative 'mastermind'

messages = Messages.new
mastermind = Mastermind.new(messages)

puts messages.welcome_message

signal = :continue

until signal == :stop
  print "> "
  input = gets.chomp
  output, signal = mastermind.execute(input)
  puts output
end
