class Matcher
  attr_reader :guess, :secret

  def initialize(guess, secret)
    @guess  = guess.upcase
    @secret = secret.upcase
  end

  def correct?
    guess == secret
  end

  def correct_colors
    colors = guess.chars.find_all { |letter| secret.include?(letter) }
    colors.uniq.length
    # @guess_count += 1

    # if colors.length >= 2
    #   "'#{input}' has #{colors.length} correct colors."
    # elsif colors.length == 1
    #   "'#{input}' has #{colors.length} correct color."
    # else
    #   "'#{input}' has no colors guessed correctly. Really? Try again!"
    # end
  end

  # similar to correct_colors, return an integer of
  # the guess' correct positons
  def correct_positions
    matched = secret.chars.zip(guess.chars)
    match = matched.select { |a| a[0] == a[1] }
    match.length
  end
end
