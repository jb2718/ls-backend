class Player
  attr_accessor :name, :move

  def initialize
    set_name
  end
end

class Human < Player
  def set_name
    n = nil
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "That is not a valid entry.  Try again!"
    end
    @name = n
  end

  def choose
    choice = nil
    loop do
      puts "Choose one: rock, paper, or scissors"
      choice = gets.chomp.downcase

      if Move::VALUES.include?(choice)
        @move = Move.new(choice)
        puts "#{@name} chose: #{@move}"
        break
      else
        puts "That is not a valid choice."
      end
    end
  end
end

class Computer < Player
  def set_name
    @name = ['Number 5', 'R2D2', 'Eve', 'Wall-E'].sample
  end

  def choose
    @move = Move.new(Move::VALUES.sample)
    puts "#{@name} chose: #{@move}"
  end
end

class Move
  VALUES = %w(rock paper scissors).freeze
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def scissors?
    @value == 'scissors'
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?) ||
      (scissors? && other_move.paper?)
  end

  def <(other_move)
    (rock? && other_move.paper?) ||
      (paper? && other_move.scissors?) ||
      (scissors? && other_move.rock?)
  end

  def to_s
    @value
  end
end

class Game
  attr_accessor :user, :computer
  def initialize
    @user = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors.  Good bye!"
  end

  def display_winner
    if user.move > computer.move
      puts "#{user.name} won!"
    elsif user.move < computer.move
      puts "#{computer.name} won!"
    else
      puts "Tie game!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "That is not a valid answer.  Please try again."
    end
    return true if answer == 'y'
    return false if answer == 'n'
  end

  def play
    display_welcome_message
    loop do
      user.choose
      computer.choose
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

my_game = Game.new
my_game.play
