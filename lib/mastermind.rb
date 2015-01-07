require_relative 'messages'
require_relative 'matcher'
require_relative 'secret_creator'

class Mastermind

  attr_reader :messages
  attr_accessor :guess_count, :secret, :game_in_progress

  def initialize
    @game_in_progress = false
    @guess_count = 0
    @messages = Messages.new
    @secret   = SecretCreator.new.generate_secret
    @start_time = Time.now
  end

  def timer
    Time.now - @start_time
  end

  def execute(input)
    puts "Secret: #{secret}"

    return exceptions(input) if exceptions(input)
    return invalids(input) if invalids(input)

    matcher = Matcher.new(input, secret)

    if matcher.correct?
      # @guess_count
      # timer
      [messages.win(@guess_count, timer), :win]
    else
      @guess_count += 1
      correct_colors = matcher.correct_colors
      correct_positions = matcher.correct_positions
      [messages.guess_feedback(correct_colors, correct_positions), :continue]
    end
  end

  def guesses
    if @guess_count > 1
      "You have guessed #{@guess_count} times\n"
    else
      "You have guessed one time\n"
    end
  end

  def invalids(input)
    invalids = input.upcase.split('').select { |i| i =~ /[^RGBY]/ }

    if invalids.length > 0
       [messages.invalid_letter, :continue]
    end
  end

  def exceptions(input)
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
