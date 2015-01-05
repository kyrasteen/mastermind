require_relative 'messages'
require_relative 'mastermind'

messages = Messages.new
mastermind = Mastermind.new(messages)

puts messages.welcome_message

signal = :continue

until signal == :stop
  input = gets.chomp
  output, signal = mastermind.execute(input)
  puts output
end
