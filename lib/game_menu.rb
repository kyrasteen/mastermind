require_relative 'messages'

class GameMenu
  attr_reader :messages

  def initialize
    @messages = Messages.new
    @active = true
  end

  def active?
    @active
  end

  def menu(input)
    puts "Start of menu loop"
    if input == 'p'
      @active = false
      [messages.take_guess, :continue]
    elsif input == 'q'
      [messages.quit_game, :stop]
    elsif input == 'i'
      [messages.instructions, :continue]
    else
      [messages.error, :continue]
    end
  end
end
