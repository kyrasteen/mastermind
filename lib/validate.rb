require_relative 'messages'

class Validate

  attr_reader :messages, :secret

  def initialize
    @messages = Messages.new
  end

  def invalids(input)
    invalids = input.upcase.split('').select { |i| i =~ /[^RGBY]/ }

    if invalids.length > 0
      [messages.invalid_letter, :continue]
    end
  end

  def exceptions(input, secret)
    if input == 'q'
      [messages.end_round, :continue]
    elsif input == 'quit'
      [messages.quit_game, :stop]
    elsif input == 'i'
      [messages.instructions, :continue]
    elsif input == 'h'
      ["#{secret[3]} is in the last position ", :continue]
    elsif input.length != 4
      [messages.wrong_number, :continue]
    end
  end
end
