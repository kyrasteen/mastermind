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

  def guess_count
    if @guess_count > 1
      puts "You have guessed #{@guess_count} times"
    else
      puts "You have guessed one time."
    end
  end

  def exceptions(input)
    input = input.upcase.split('')
    invalids = input.select do |i|
      i =~ /[^RGBY]/
    end

    if input == 'q'
      return [messages.end_round, :continue]
    elsif input == 'quit'
      return [messages.quit_game, :stop]
    elsif input == 'i'
      return [messages.instructions, :continue]
    elsif input == 'h'
      return ["#{input[3]} is in the last position ", :continue]
    elsif invalids.length > 0
      return [messages.invalid_letter, :continue]
    elsif input.length != 4
      return [messages.wrong_number, :continue]
    end
  end

  def color_match(input)
    colors = input.find_all { |letter| @secret.include?(letter) }

    color_match = puts "'#{input.join('')}' has #{colors.uniq.length} correct colors."

    if colors.length > 0
      @guess_count += 1
      [color_match, :continue]
    else
      @guess_count += 1
      puts "'#{input.join('')}' has no colors guessed correctly. Really? Try again!\n>"
    end
  end

  def play_game(input)

    puts exceptions(input)
    ####need to return method if this method returns anything

    start_time = Time.now

    input = input.upcase.split('')

    color_match(input)

    matched = @secret.zip(input)

    match = matched.select { |a| a[0] == a[1] }

    if match.length.zero?
      puts ["You guessed no positions correctly", :continue]
    elsif match.length == 4
      timer = Time.now - start_time
      puts ["Congratulations! You have won the game with sequence '#{input.join('')}'!\n You took #{@guess_count} guesses and took #{timer}.\n Hit 'p' to play again or 'quit' to quit.>", :continue]
    else
      exact_match =  puts "'#{input.join('')}' has #{match.length} letters at the correct position."
      [exact_match, :continue]
    end
    guess_count
  end
end

messages = Messages.new
mm = Mastermind.new(messages)
mm.execute('p')
