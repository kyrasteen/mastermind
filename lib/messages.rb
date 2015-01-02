require_relative 'mastermind'

class Messages

  def welcome_message
    "Welcome to Mastermind, \nhit 'p' for play, 'i' for instructions, or 'q' to quit!"
  end

  def instructions
    "Mastermind is a guessing game. \nThe secret holds four letters. \nThe letters represent the colors red, blue, green, and yellow. \nThe secret colors can be repeated and in any order. \nThe prompt will allow you to guess what four colors the secret holds until you are correct."
  end

  def error
    "Error please only enter 'p','q', or 'i'."
  end

  def exact_match
    puts "You got #{match.length} matches."
    "Match at position #{match.join(',')}"
  end

  def color_match
    puts "You guessed #{colors.length} colors correctly"
    "Colors:#{colors.join(',')}"
  end

  def end_round
    "Thanks for playing this round!"
  end

  def quit_game
    "Thanks for playing!"
  end

  def take_guess
    "What do you think the secret is?"
  end

  def invalid_letter
    "Invalid letter, please only choose between 'R', 'B', 'G', and 'Y'"
  end

  def too_many
    "Too many items. Please only enter four items."
  end

  def win
    "Correct! You have won the game!"
  end

end
