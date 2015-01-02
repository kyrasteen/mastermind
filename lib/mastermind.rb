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

  def game_menu(input)
    if input == 'p'
      @secret = ['R','G','B','Y'].shuffle
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
    input = input.split('')
    invalids = input.select do |i|
      i.capitalize != "R" || "G" || "B" || "Y"
    end

    if input == 'q'
      return [messages.end_round, :continue]
    elsif input.length > 4
      return [messages.too_many, :continue]
    elsif invalids.length > 0
      return [messages.invalid_letter, :continue]
    else

      #if guess includes a letter that entry includes
      #return correct color message

      input = input.map { |letter| letter.upcase}
      matched = @secret.zip(input)

      #exceptions - guess = rgbb secret = gbrr
      colors = input.find_all { |letter| @secret.include? }
      #FIX returns array of true/false
      if colors.length > 0
        [messages.color_match, :continue]
        # match = colors.length
      end

  #needs to find the number of matches and position
      match = matched.find_index do |a|
            a[0] == a[1]
        #can my other class see match?
      end

      if match.length == 4
        [messages.win, :continue]
      else
        [messages.exact_match, :continue]
      end
    end
  end
end
messages = Messages.new
mm = Mastermind.new(messages)
mm.execute('p')
