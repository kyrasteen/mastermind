require_relative 'test_helper.rb'
require_relative '../lib/mastermind'

class MastermindTest < Minitest::Test

  def setup
    @mm = Mastermind.new
  end

  def test_it_exists
    assert @mm
  end

  def test_it_keeps_count_of_guesses
    @mm.guess_count = 0
    @mm.execute('p')
    @mm.execute('gggy')
    @mm.execute('gbgr')
    assert_equal @mm.guess_count, 2
  end

  def test_it_keeps_time
    @mm.execute('p')
    @mm.secret = 'GGBB'
    time = @mm.timer
    assert time.is_a?(Float)
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
