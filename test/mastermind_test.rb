require 'minitest/autorun'
require 'minitest/pride'
require './lib/mastermind'

class MastermindTest < Minitest::Test

  def setup
    messeges = Messeges.new
    @mm = Mastermind.new(messeges)
  end

  def test_it_exists
    assert MastermindTest
  end

#if this does not pass make sure passing in a 'p' is an exception
#to the four letters in entry requirement

  def test_it_starts_a_game
    assert @mm.entry.nil?
    @mm.execute('p')
    assert @mm.entry.is_a?(String)  #string or array?
  end

  def test_it_only_takes_four_letters_in_entry
    assert
  end

  def test_it_wins
    mm = Mastermind.new
    result = mm.execute("BBGB")
    assert result.downcase.include?("win")
  end
end
