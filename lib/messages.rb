
class Messages
  def welcome_message
    "Welcome to MASTERMIND, \nhit 'p' for play, 'i' for instructions, 'h' for hint after game has begun,'q' to quit a round, or 'quit' to end a game!"
  end

  def instructions
    "Mastermind is a guessing game. \nThe secret holds four letters. \nThe letters represent the colors red, blue, green, and yellow. \nThe secret colors can be repeated and in any order. \nThe prompt will allow you to guess what four colors the secret holds until you are correct."
  end

  def error
    "Error please only enter 'p' for play,'q' for quit, or 'i' for instructions."
  end

  def end_round
    "You have ended this round. Thanks for playing!"
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

  def wrong_number
    "Please enter four letters ONLY."
  end

  def win(guess_count, time)
    "Congratulations, you have won the game with #{guess_count} guesses and took #{time}to finish"
  end

  def guess_feedback(correct_colors, correct_positions)
    "You guessed #{correct_colors} correct color(s) and #{correct_positions} correct position(s)"
  end
end
