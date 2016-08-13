require './player.rb'
require './score.rb'
require './move.rb'

def space_output(phrase)
  puts "\n\n#{phrase}"
end

class Game
  attr_accessor :user, :computer
  def initialize
    @user = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!\n\n"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock.  Good bye!"
  end

  def tally_score
    if user.move > computer.move
      user.score.increment
    elsif user.move < computer.move
      computer.score.increment
    else
      # Tie - Do nothing
    end
  end

  def display_winner
    if user.move > computer.move
      space_output "#{user.name} won the round!"
      puts "#{user.name} won the entire game" if user.score.maxed_out?
    elsif user.move < computer.move
      space_output "#{computer.name} won the round!"
      puts "#{computer.name} won the entire game" if computer.score.maxed_out?
    else
      space_output "Tie game!"
    end
    user.display_score
    computer.display_score
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
    user.score.reset
    computer.score.reset
  end

  def play
    display_welcome_message
    loop do
      reset_game if user.score.maxed_out? || computer.score.maxed_out?
      user.choose
      computer.choose
      tally_score
      display_winner
      break unless play_again?
      system "clear"
    end
    display_goodbye_message
  end
end