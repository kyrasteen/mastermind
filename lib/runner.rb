
require_relative 'mastermind'
require_relative 'game_menu'

class Runner

  attr_reader :mastermind, :menu

  def initialize
    @mastermind = Mastermind.new
    @menu = GameMenu.new
  end

  def run
    feedback = menu.start
    output = feedback[0]
    signal = feedback[1]
    puts output


    until signal == :stop
      print "> "
      input = gets.chomp

      if menu.active?
        feedback = menu.execute(input)
      else
        feedback = mastermind.execute(input)
        message = feedback[0]
        signal  = feedback[1]

        if signal == :win
          puts message
          @mastermind = Mastermind.new
          feedback = menu.start
        end
      end

      output = feedback[0]
      signal = feedback[1]
      puts output
    end
  end
end

runner = Runner.new
runner.run
