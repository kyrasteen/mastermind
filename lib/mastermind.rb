require_relative 'messeges'

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

    # secret = "BBGB"
    # if input == secret
    #   "You win!"
    # else
    #   "Guess again!"
    # end

    if input == 'q'
      return [messages.end_round, :continue]
    end
  end

  def game_menu(input)
    if input == 'p'
      @secret = ['R','G','B','Y'].shuffle
      @game_in_progress = true
      [messages.take_guess, :continue]
    elsif input == 'q'
      [messages.quit_game, :stop]
    end
  end

  def play_game(input)
    if input == 'q'
      return [messages.end_round, :continue]
    end

    #what if entry is more than four items?
    if input.length > 4
      return [messages.too_many, :continue]
    end
    #if an el of input has a letter not representing a color
    #array, return message and continue
    guesses = input.map do |i|
      i.include?('Q')
    end

    if guesses[2] == true
      return [messages.invalid_letter, :continue]
    end


    guess = input#.split('')
    guess = guess.map { |letter| letter.upcase}
    matched = @secret.zip(guess)

    match = 0
     matched.each do |a|
      if a[0] == a[1]
        match += 1 #can my other class see colors?
      end
      [messages.exact_match, :continue]
    end

    #if guess includes a letter that entry includes
    #return correct color message
    colors = guess.find_all { |letter| @secret.include?(letter)} #what does this return?
      if colors.length > 0
        [messages.color_match, :continue]
        match = colors.length
      end


  end

end
