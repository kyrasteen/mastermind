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
  skip
    @mm.execute('p')
    puzzle = @secret
    messages = Messages.new
    master = Mastermind.new(messages)
    master.execute('p')
    puzzler = @secret
    assert puzzle != puzzler
  end

  def test_it_only_takes_four_letters_in_guess
    skip
    @mm.execute('p')
    @mm.secret = ['R','G','G','B']
    message, signal = @mm.execute('ygbbyr')
    assert message.include?("Too many")
    assert_equal signal, :continue
  end

  def test_it_only_accepts_four_color_choices_in_guess
    skip
    @mm.execute('p')
    message, signal = @mm.execute('yGQr')
    assert message.include?("Invalid")
    assert_equal signal, :continue
  end

  def test_it_ends_a_game
    skip
    message, signal = @mm.execute('q')
    assert message.include?('Thanks')
    assert_equal signal, :stop
  end

  def test_it_ends_a_round
    skip
    @mm.execute('p')
    message, signal = @mm.execute('q')
    assert message.include?('ended round')
    assert_equal signal, :continue
  end

  def test_it_has_instructions
    message, signal = @mm.execute('i')
    assert message.include?('guess')
    assert_equal signal, :continue
  end

  def test_matching_one_letter_at_correct_place
    skip
    @mm.execute('p')
    @mm.secret = 'rrby'
    message, signal = @mm.execute('ggbr')
    assert message.include?('the third color is correct')
    assert_equal signal, :continue
  end

  def test_matching_more_than_one_letter
    skip
  end

  def test_it_wins
    skip
    @mm.execute('p')
    @mm.secret = 'bbgb'
    message, signal = @mm.execute("BBGB")
    assert message.include?("win")
    assert_equal signal, :continue
  end
end
