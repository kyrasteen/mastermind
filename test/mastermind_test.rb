require 'minitest/autorun'
require 'minitest/pride'

require '../lib/mastermind'

class MastermindTest < Minitest::Test

  attr_reader :mm

  def setup
    messages = Messages.new
    @mm = Mastermind.new(messages)
  end

  def test_it_exists
    assert MastermindTest
  end

#if this does not pass make sure passing in a 'p' is an exception
#to the four letters in entry requirement

  def test_it_starts_a_game
    assert @mm.secret.nil?
    @mm.execute('p')
    assert @mm.secret.is_a?(Array)  #string or array?
  end

  def test_it_generates_random_four_letters
    #not passing no message given
    @mm.execute('p')
    puzzle = @secret
    messages = Messages.new
    master = Mastermind.new(messages)
    master.execute('p')
    puzzler = @secret
    assert puzzle != puzzler
  end

  def test_it_only_takes_four_letters_in_guess
    @mm.execute('p')
    @mm.secret = ['R','G','G','B']
    message, signal = @mm.execute(['Y','B','B','G','y'])
    assert message.include?("Too many")
    assert_equal signal, :continue
  end

  def test_it_only_accepts_four_color_choices_in_guess
    @mm.execute('p')
    message, signal = @mm.execute(['y','G','Q','r'])
    assert message.include?("Invalid")
    assert_equal signal, :continue
  end

  def test_it_ends_a_game
    message, signal = @mm.execute('q')
    assert message.include?('Thanks')
    assert_equal signal, :stop
  end

  def test_it_ends_a_round
    skip
  end

  def test_guess_includes_correct_colors
    skip
  end

  def test_matching_colors_in_guess_at_correct_place
    skip
  end

  def test_it_wins
    skip
    mm = Mastermind.new
    result = mm.execute("BBGB")
    assert result.downcase.include?("win")
  end
end
