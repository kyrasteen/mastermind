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
    assert Mastermind
  end

  def test_it_starts_a_game
    assert @mm.secret.nil?
    output, signal = @mm.execute('p')
    assert @mm.secret.is_a?(Array)
    assert output.include?('What do you think')
    assert_equal signal, :continue
  end

  def test_it_generates_random_four_letters
    @mm.execute('p')
    puzzle = @mm.secret
    messages = Messages.new
    master = Mastermind.new(messages)
    master.execute('p')
    puzzler = master.secret
    assert puzzle != puzzler
  end

  def test_it_only_takes_four_letters_in_guess
    @mm.execute('p')
    @mm.secret = 'RGGB'.split('')
    output, signal = @mm.execute('ygbbyr')
    assert output.include?("Please enter")
    assert_equal signal, :continue
  end

  def test_it_only_accepts_four_color_choices_in_guess
    @mm.execute('p')
    output, signal = @mm.execute('yGKr')
    assert output.include?("Invalid")
    assert_equal signal, :continue
  end

  def test_it_ends_a_game
    output, signal = @mm.execute('q')
    assert output.include?('Thanks')
    assert_equal signal, :stop
  end

  def test_it_ends_a_round
    @mm.execute('p')
    output, signal = @mm.execute('q')
    assert output.include?('ended this round')
    assert_equal signal, :continue
  end

  def test_it_has_instructions
    output, signal = @mm.execute('i')
    assert output.include?('guess')
    assert_equal signal, :continue
  end

  def test_it_gives_a_hint
    @mm.execute('p')
    output, signal = @mm.execute('h')
    assert output.include?('last position')
    assert signal, :continue
  end

  def test_matching_one_letter_at_correct_place
    @mm.execute('p')
    @mm.secret = 'rrby'.split('')
    output, signal = @mm.execute('ggbr')
    assert output.include?('correct')
    assert_equal signal, :continue
  end

  def test_matching_more_than_one_letter
    @mm.execute('p')
    @mm.secret = 'yygg'.split('')
    output, signal = @mm.execute('Yggg')
    assert output.include?('correct')
    assert signal, :continue
  end

  def test_it_keeps_count_of_guesses
    @mm.execute('p')
    @mm.execute('gggy')
    @mm.execute('gbgr')
    assert_equal @mm.guess_count, 2
  end

  def test_it_wins
    @mm.execute('p')
    @mm.secret = 'bbgb'.split('')
    output, signal = @mm.execute("bbgb")
    assert output.include?("correct")
    assert_equal signal, :continue
  end
end
