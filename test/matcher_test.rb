require_relative 'test_helper'
require_relative '../lib/matcher'

class MatcherTest < Minitest::Test

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

  def test_how_many_correct_positions_in_guess
    guess = 'grrr'
    secret = 'byrr'
    matcher = Matcher.new(guess, secret)
    assert_equal 2, matcher.correct_positions
  end
end
