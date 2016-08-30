require './player.rb'
require './move.rb'
require './history.rb'

require 'pry'

def space_output(phrase)
  puts "\n\n#{phrase}"
end

class Game
  attr_accessor :user, :computer, :history
  def initialize
    @history = History.new
    @user = Human.new
    @computer = Computer.new(@history)
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!\n\n"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock.  Good bye!"
  end

  def determine_winner
    if user.move > computer.move
      "user"
    elsif user.move < computer.move
      "computer"
    else
      "tie"
    end
  end

  def tally_score
    case determine_winner
    when 'user'
      user.score.increment
    when 'computer'
      computer.score.increment
    end
  end

  def display_game_winner
    puts "#{user.name} won the entire game" if user.won_entire_game?
    puts "#{computer.name} won the entire game" if computer.won_entire_game?
  end

  def display_winner
    case determine_winner
    when 'user'
      space_output "#{user.name} won the round!"
    when 'computer'
      space_output "#{computer.name} won the round!"
    when 'tie'
      space_output "Tie game!"
    end

    display_game_winner
    user.display_score
    computer.display_score
  end

  def update_history
    record = {
      user: user.move.value,
      computer: computer.move.value,
      winner: determine_winner
    }
    history.insert(record)
  end

  def show_history
    puts history
  end

  def play_again?
    answer = nil
    loop do
      space_output "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "That is not a valid answer.  Please try again."
    end
    return true if answer == 'y'
    return false if answer == 'n'
  end

  def reset_game
    puts "Starting new game..."
    user.reset_score
    computer.reset_score
  end

  def max_score?
    user.won_entire_game? || computer.won_entire_game?
  end

  def play
    display_welcome_message
    loop do
      system "clear"
      reset_game if max_score?
      user.choose
      computer.choose
      tally_score
      display_winner
      update_history
      break unless play_again?
    end
    show_history
    display_goodbye_message
  end
end
