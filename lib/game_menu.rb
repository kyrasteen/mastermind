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

  def start
    @active = true
    [messages.welcome_message, :continue]
  end

  def execute(input)
    case input
    when 'q' then [messages.quit_game, :stop]
    when 'i' then [messages.instructions, :continue]
    when 'p'
      @active = false
      [messages.take_guess, :continue]
    else
      [messages.error, :continue]
    end
  end
end
