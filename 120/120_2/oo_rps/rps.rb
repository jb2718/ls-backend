class Player
  attr_accessor :name, :move

  def initialize(name)
    @name = name
  end

  def choose
    # @move = move
    puts "Chosing a move"
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
    @user = Player.new('User')
    @computer = Player.new('Player')
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
    # compare choices/determine winner
    # display winner
    display_goodbye_message
  end
end

my_game = Game.new
my_game.play