require_relative 'test_helper.rb'
require_relative '../lib/mastermind'

class MastermindTest < Minitest::Test

  def setup
    @mm = Mastermind.new
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

  def test_no_matches
    @mm.execute('p')
    @mm.secret = 'BBGG'.split('')
    output = @mm.exact_match('ryby')
    assert output.include?('no positions')
  end

  def test_matching_one_letter_at_correct_place
    @mm.execute('p')
    @mm.secret = 'RRBY'.split('')
    output = @mm.exact_match('ggbr')
    assert output.include?('correct')
  end

  def test_matching_more_than_one_letter_at_correct_place
    @mm.execute('p')
    @mm.secret = 'YYGG'.split('')
    output = @mm.exact_match('Yggg')
    assert output.include?('correct')
  end

  def test_it_keeps_count_of_guesses
    @mm.execute('p')
    @mm.execute('gggy')
    @mm.execute('gbgr')
    assert_equal @mm.guess_count, 2
  end

  def test_it_keeps_time
    @mm.execute('p')
    @mm.secret = 'GGBB'.split('')
    @mm.execute('gggg')
    @mm.execute('yyyy')
    output = @mm.exact_match('ggbb')
    assert output.include?('and took')
  end

  def test_it_wins
    @mm.execute('p')
    @mm.secret = 'BBGB'.split('')
    @mm.execute('gggg')
    @mm.execute('yyyy')
    output = @mm.exact_match("bbgb")
    assert output.include?("Congratulations!")
  end

  def test_it_fully_executes
    @mm.execute('p')
    output = @mm.execute('gggy')
    assert output.include?('guessed')
  end
end
