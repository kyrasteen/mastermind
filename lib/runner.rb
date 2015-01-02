require_relative 'messages'
require_relative 'mastermind'

messages = Messages.new
mastermind = Mastermind.new(messages)

puts messages.welcome_messege

signal :continue

until signal == :stop
  input = gets.chomp
  message, signal = mastermind.execute(input)
  puts message
end
