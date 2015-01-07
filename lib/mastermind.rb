require_relative 'messages'
require_relative 'matcher'
require_relative 'secret_creator'
require_relative 'validate'

class Mastermind

  attr_reader :messages
  attr_accessor :guess_count, :secret, :game_in_progress

  def initialize
    @game_in_progress = false
    @guess_count = 0
    @messages   = Messages.new
    @secret     = SecretCreator.new.generate_secret
    @start_time = Time.now
  end

  def timer
    Time.now - @start_time
  end

  def execute(input)
     validator = Validate.new
     return validator.exceptions(input) if validator.exceptions(input)
     return validator.invalids(input) if validator.invalids(input)

    matcher = Matcher.new(input, secret)

    if matcher.correct?
      @guess_count
      timer
      [messages.win(@guess_count, timer), :win]
    else
      @guess_count += 1
      correct_colors = matcher.correct_colors
      correct_positions = matcher.correct_positions
      [messages.guess_feedback(correct_colors, correct_positions, @guess_count), :continue]
    end
  end
  
end
