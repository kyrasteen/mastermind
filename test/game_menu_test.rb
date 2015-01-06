require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/game_menu'

class GameMenuTest < Minitest::Test
  def setup
    messages = Messages.new
    @gm = GameMenu.new(messages)
  end

  def test_it_has_instructions
    output, signal = @gm.menu('i')
    assert output.include?('guessing game')
    assert_equal signal, :continue
  end

  def test_it_quits_on_q
    output , signal = @gm.menu('q')
    assert output.include?('Thanks')
    assert_equal signal, :stop
  end
end