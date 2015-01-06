require_relative 'messages'
require 'pry'

class Mastermind

  attr_reader :messages, :game_in_progress
  attr_accessor :secret, :guess_count

  def initialize(messages)
    @messages = messages
    @game_in_progress = false
    @guess_count = 0
  end

  def execute(input)
    if !game_in_progress
      game_menu(input)
    else
      play_game(input)
    end
  end

  def generate_secret(size = 4)
    charset = %w{B G R Y}
    (0...size).map{ charset.to_a[rand(charset.size)] }
  end

  def game_menu(input)
    if input == 'p'
      @secret = generate_secret
      @game_in_progress = true
      [messages.take_guess, :continue]
    elsif input == 'q'
      [messages.quit_game, :stop]
    elsif input == 'i'
      [messages.instructions, :continue]
    else
      [messages.error, :continue]
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
       ["#{@secret[3]} is in the last position ", :continue]
    elsif input.length != 4
       [messages.wrong_number, :continue]
    end
  end

  def color_match(input)
    colors = input.upcase.split('').find_all { |letter| @secret.include?(letter) }
    colors = colors.uniq
    @guess_count += 1

    if colors.length >= 2
      "'#{input}' has #{colors.length} correct colors."
    elsif colors.length == 1
      "'#{input}' has #{colors.length} correct color."
    else
      "'#{input}' has no colors guessed correctly. Really? Try again!"
    end
  end

  def exact_match(input)
    matched = @secret.zip(input.upcase.split(''))
    match = matched.select { |a| a[0] == a[1] }

    if match.length.zero?
      "You guessed no positions correctly"
    elsif match.length == 4
      end_time = Time.now
      timer = end_time - @start_time
      "Congratulations! You have won the game with sequence '#{input}'!\n You took #{@guess_count} guesses and took #{timer}.\n Hit 'p' to play again or 'quit' to quit."
    elsif match.length == 1
      "'#{input}' has #{match.length} letter at the correct position."
    else
      "'#{input}' has #{match.length} letters at the correct position."
    end
  end

  def play_game(input)
    @start_time = Time.now

    return exceptions(input) if exceptions(input)
    return invalids(input) if invalids(input)

    puts color_match(input)
    puts exact_match(input)
    puts guesses
  end
end
