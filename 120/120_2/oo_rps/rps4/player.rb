require './ai.rb'
require './score.rb'
require 'pry'
require 'yaml'
PERSONALITIES = YAML.load_file('personality_prefs.yml')

class Player
  attr_accessor :name, :move, :score

  def initialize
    @score = Score.new
    set_name
  end

  def display_score
    coda = @score.value == 1 ? "point" : "points"
    puts "#{name} has #{@score} #{coda}."
  end

  def won_entire_game?
    score.maxed_out?
  end

  def reset_score
    score.reset
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
      puts "Choose one: rock, paper, scissors, lizard, or spock"
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

class Personality
  attr_reader :name, :prefs
  def initialize
    @name = ['Number 5', 'R2D2', 'Eve', 'Wall-E'].sample
    @prefs = {}
    set_preferences
  end

  def preference(name, type)
    PERSONALITIES[name]["prefs"][type]
  end

  def set_preferences
    @prefs = {
      tendency_threshhold: preference(name, "tendency_threshhold"),
      favorite_move: preference(name, "favorite_move"),
      streak_window: preference(name, "streak_window"),
      streak_length: preference(name, "streak_length")
    }
  end
end

class Computer < Player
  def initialize(history)
    @personality = Personality.new
    @history = history
    super()
    @ai = AI.new(@history, 'user', 'computer', @personality.prefs)
  end

  def set_name
    @name = @personality.name
  end

  def choose
    @move = Move.new(@ai.calculate_next_move)
    puts "#{@name} chose: #{@move.value}"
  end
end
