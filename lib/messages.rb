
class Messages

  def welcome_message
    "Welcome to Mastermind, \nhit 'p' for play, 'i' for instructions, or 'q' to quit!"
  end

  def instructions
    "Mastermind is a guessing game. \nThe secret holds four letters. \nThe letters represent the colors red, blue, green, and yellow. \nThe secret colors can be repeated and in any order. \nThe prompt will allow you to guess what four colors the secret holds until you are correct."
  end

  def error
    "Error please only enter 'p','q', or 'i'.\n>"
  end

  def end_round
    "You have ended this round. Thanks for playing!\n>"
  end

  def quit_game
    "Thanks for playing!"
  end

  def take_guess
    "What do you think the secret is? \n>"
  end

  def invalid_letter
    "Invalid letter, please only choose between 'R', 'B', 'G', and 'Y'\n>"
  end

  def too_many
    "Too many items. Please only enter four items.\n>"
  end

  def win
    "Correct! You have won the game!\n>"
  end

end
