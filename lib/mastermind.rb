require_relative 'messages'
require 'pry'

class Mastermind

  attr_reader :messages, :game_in_progress, :colors, :match
  attr_accessor :secret

  def initialize(messages)
    @messages = messages
    @game_in_progress = false
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

  def play_game(input)

    if input == 'q'
      return [messages.end_round, :continue]
    end

    input = input.split('')

    if input.length > 4
      return [messages.too_many, :continue]
    end

    invalids = input.select do |i|
      i =~ /[^rgby]/
    end

    if invalids.length > 0
      return [messages.invalid_letter, :continue]
    end

    if
      input = input.map { |letter| letter.upcase}
      matched = @secret.zip(input)
      colors = []

      input.find_all do |letter|
        if @secret.include?(letter)
          colors << letter
        end
      end

      color_match = puts "You guessed #{colors.uniq.length} colors correctly. Colors:#{colors.uniq.join(',')}"

      if colors.length > 0
        [color_match, :continue]
      else
        puts "You guessed no colors correctly. Really? Try again!\n>"
      end

      match = []
      matched.each do |a|
            if a[0] == a[1]
              puts "You guessed the color '#{a[0]}' in the correct position!"
            match << matched.index(a) + 1
          end
      end

       if match.length.zero?
          ["You guessed no positions correctly", :continue]
       elsif match.length == 4
         [messages.win, :continue]
      else
        exact_match = "Matched at position #{match.join(',')}"
        [exact_match, :continue]
      end
    end
  end
end

messages = Messages.new
mm = Mastermind.new(messages)
mm.execute('p')
