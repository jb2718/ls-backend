require_relative 'util'
require_relative 'brain'

class Player
  attr_accessor :score, :name, :ai
  attr_reader :mark

  def initialize
    @score = 0
    @name = set_name
    @mark = set_mark
    @ai = Brain.new
  end

  def set_name
    choice = ''
    loop do
      prompt("What's your name? ")
      choice = gets.chomp
      if choice.empty? || choice.start_with?(' ')
        prompt("Your entry is invalid.  Please try again!")
      else
        break
      end
    end
    choice
  end

  def set_mark
    choice = ''
    loop do
      prompt("Choose any letter from A to Z (except O) for your mark: ")
      choice = gets.chomp
      if /([a-z])/.match(choice.downcase).nil? ||
         choice.size > 1 ||
         choice.casecmp('o') == 0
        prompt("Your entry is invalid.  Please try again!")
      else
        break
      end
    end
    choice
  end

  def add_point
    self.score += 1
  end

  def reset_score
    self.score = 0
  end
end

class Computer < Player
  def set_name
    ['Snapp', 'Crackle', 'Pop'].sample
  end

  def set_mark
    "O"
  end

  def next_move(current_moves, open_moves)
    move = ai.complete_two_in_row(current_moves)
    return move if open_moves.include?(move)
    nil
  end
end
