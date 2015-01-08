require_relative 'test_helper.rb'
require_relative '../lib/game_menu'

class GameMenuTest < Minitest::Test
  attr_reader :menu

  def setup
    @menu = GameMenu.new
  end

  def test_it_has_instructions
    output, signal = menu.execute('i')
    assert output.include?('guessing game')
    assert_equal signal, :continue
  end

  def test_it_quits_on_q
    output , signal = menu.execute('q')
    assert output.include?('Thanks')
    assert_equal signal, :stop
  end

  def test_menu_is_active_until_played_game
    assert menu.active?
    menu.execute('p')
    assert menu.active? == false
  end

  def test_it_starts_a_game
    assert @active = true
    output, signal = @menu.execute('p')
    assert output.include?('What do you think')
    assert_equal signal, :continue
  end

end
