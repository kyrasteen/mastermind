require_relative 'test_helper.rb'
require_relative '../lib/validate'

class ValidateTest < Minitest::Test

  attr_reader :secret

  def setup
    @secret = 'RRGG'
    @validator = Validate.new
  end

  def test_it_gives_a_hint
    output, signal = @validator.exceptions('h', secret)
    assert output.include?('last position')
    assert signal, :continue
  end

  def test_it_has_instructions
    output, signal = @validator.exceptions('i', secret)
    assert output.include?('guess')
    assert_equal signal, :continue
  end

  def test_it_ends_a_game
    output, signal = @validator.exceptions('quit', secret)
    assert output.include?('Thanks')
    assert_equal signal, :stop
  end

  def test_it_ends_a_round
    output, signal = @validator.exceptions('q', secret)
    assert output.include?('ended this round')
    assert_equal signal, :continue
  end

  def test_it_only_takes_four_letters_in_guess
    output, signal = @validator.exceptions('ygbbyr', secret)
    assert output.include?("Please enter")
    assert_equal signal, :continue
  end

  def test_it_only_accepts_four_color_choices_in_guess
    output, signal = @validator.invalids('yGKr')
    assert output.include?("Invalid")
    assert_equal signal, :continue
  end
end
