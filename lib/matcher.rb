
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
  end

  def correct_positions
    matched = secret.chars.zip(guess.chars)
    match = matched.select { |a| a[0] == a[1] }
    match.length
  end
end
