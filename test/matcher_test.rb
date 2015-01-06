require_relative 'test_helper'
require_relative '../lib/matcher'

class MatcherTest < Minitest::Test

  # Matcher objects take a guess and a secret
  # check if guess is correct
  # return the amount of correct colors
  # return the amount of correct positions
  # Matcher#correct?
  # Matcher#correct_colors
  # Matcher#correct_positions

  # Setup
  # exercise
  # verify
  # teardown


  def test_it_exists
    matcher = Matcher.new('kyra', 'cool')
    assert matcher
  end

  def test_whether_a_guess_is_correct
    guess = 'ggbb'
    secret = 'ggbb'
    matcher = Matcher.new(guess, secret)
    assert matcher.correct?
  end

  def test_whether_a_guess_is_incorrect
    guess = 'ggbb'
    secret = 'gyyy'
    matcher = Matcher.new(guess, secret)
    refute matcher.correct?
  end

  def test_how_many_correct_colors_in_guess
    guess = 'gyyy'
    secret = 'gybb'
    matcher = Matcher.new(guess, secret)
    assert_equal 2, matcher.correct_colors
  end
end
