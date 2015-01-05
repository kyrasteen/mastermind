
class Messages

  def welcome_message
    "Welcome to MASTERMIND, \nhit 'p' for play, 'i' for instructions, 'h' for hint after game has begun,'q' to quit a round, or 'quit' to end a game!"
  end

  def instructions
    "Mastermind is a guessing game. \nThe secret holds four letters. \nThe letters represent the colors red, blue, green, and yellow. \nThe secret colors can be repeated and in any order. \nThe prompt will allow you to guess what four colors the secret holds until you are correct.\n>"
  end

  def error
    "Error please only enter 'p' for play,'q' for quit, or 'i' for instructions.\n>"
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

  def wrong_number
    "Please enter four letters ONLY.\n>"
  end
end
