class Player
  attr_accessor :name, :move

  def initialize(player_type)
    # @name = name
    @player_type = player_type
  end

  def choose
    if @player_type == :human
      choice = nil
      loop do
        puts "Choose one: rock, paper, or scissors"
        choice = gets.chomp.downcase

        if %w(rock paper scissors).include?(choice)
          @move = choice
          puts "You chose: #{@move}"
          break
        else
          puts "That is not a valid choice."
        end
      end
    else
      @move = %w(rock paper scissors).sample
      puts "Computer chose: #{@move}"
    end
  end
end

class Move
  def initialize
  end

  def compare
  end
end

class Rule
  def initialize
  end
end

class Game
  attr_accessor :user, :computer
  def initialize
    @user = Player.new(:human)
    @computer = Player.new(:computer)
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors.  Good bye!"
  end

  def play
    display_welcome_message
    user.choose
    computer.choose
    # determine_winner
    # display_winner
    display_goodbye_message
  end
end

my_game = Game.new
my_game.play