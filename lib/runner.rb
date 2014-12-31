require './lib/messages'
require './lib/mastermind'

messages = Messeges.new
mastermind = Mastermind.new(messages)

puts messages.welcome_messege

signal :continue

until signal == :stop
  input = gets.chomp
  message, signal = mastermind.execute(input)
  puts message
end

# input = ""
# mastermind = Mastermind.new
#
# while input != "q"
#   print "> "
#   input = gets.chomp
#   puts mastermind.execute(input)
# end
# puts "Goodbye!"
