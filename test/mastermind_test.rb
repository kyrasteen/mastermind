require_relative 'test_helper.rb'
require_relative '../lib/mastermind'

class MastermindTest < Minitest::Test

  def setup
    @mm = Mastermind.new
  end

  def test_it_exists
    assert Mastermind
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
    output, signal = @mm.execute('quit')
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

  def test_it_keeps_count_of_guesses
    @mm.execute('p')
    @mm.execute('gggy')
    @mm.execute('gbgr')
    assert_equal @mm.guess_count, 2
  end

  def test_it_keeps_time
    @mm.execute('p')
    @mm.secret = 'GGBB'
    @mm.execute('gggg')
    @mm.execute('yyyy')
    output, signal = @mm.execute('ggbb')
    assert output.include?('and took')
    assert_equal signal, :win
  end

  def test_it_wins
    @mm.secret = 'BBGB'
    @mm.execute('gggg')
    @mm.execute('yyyy')
    output, signal = @mm.execute("bbgb")
    assert output.include?("Congratulations")
    assert signal = :win
  end

end
