require 'pry'

class History
  attr_reader :table

  def initialize
    @table = []
  end

  def to_s
    puts "================\n" + "History of Moves\n" + "================\n"
    table.each_with_index do |data, idx|
      puts "Round: #{idx + 1}"
      puts "User Move: #{data[:user]}"
      puts "Computer Move: #{data[:computer]}"
    end
  end

  def insert(record)
    @table << record
  end

  def find_by_round(round)
    @table[round]
  end

  def find_by(attribute, value)
    @table.select do |record|
      record[attribute.to_sym] == value
    end
  end

  def length
    @table.length
  end
end

class AI
  
  def initialize(history, enemy, protagonist)
    @game_hx = history
    @enemy = enemy
    @protagonist = protagonist
  end

  def enemy_tendency?(move, threshhold)
    num_moves = @game_hx.find_by(@enemy, move).length
    total_moves = @game_hx.length
    average = num_moves.to_f/total_moves.to_f
    return true if threshhold < average
    false
  end

  def enemy_next_likely?(move, times, window)
      range_start = (@game_hx.length - window) + 1
      range_end = @game_hx.length
      last_n_moves = []
      (range_start..range_end).each do |idx|
        last_n_moves << @game_hx.find_by_round(idx - 1)
      end
      last_n_moves_count = last_n_moves.length

      counter = 0
      in_a_rows = []
      last_n_moves.each do |record|
        if record[@enemy.to_sym] == move
          counter +=1 
        else
          in_a_rows << counter
          counter = 0
        end
        in_a_rows << counter
      end

      return true if in_a_rows.max > times
      false

      # if enemy history includes move <x> y times in a row
      #   pick something that beats x
      # else
      #   don't use this to determine your move
      # end
  end

  def percent_loss(move)
    all_moves = @game_hx.find_by(@protagonist, move)
    all_moves_count = all_moves.length
    loser_moves = []
    loser_moves =  all_moves.select do |record|
                    record[:winner] == @enemy
                  end
    times_beaten = loser_moves.length
    percentage = times_beaten.to_f / all_moves_count.to_f
    percentage
  end

  def opposing_move(move)
    case move
    when 'rock', 'spock'
      'paper'
    when 'paper', 'lizard'
      'scissors'
    when 'scissors', 'lizard'
      'rock'
    when 'scissors', 'rock'
      'spock'
    when 'spock', 'paper'
      'lizard'
    end
  end

  # part of the personality of different cpu players will be to define the percentages and 
  # threshholds - so each personality will get its own AI object and set the config settings
end

hx = History.new

r1 = {"user": "rock", "computer": "scissors", "winner": "user"}
r2 = {"user": "lizard", "computer": "rock", "winner": "computer"}
r3 = {"user": "scissors", "computer": "rock", "winner": "computer"}
r4 = {"user": "lizard", "computer": "rock", "winner": "computer"}

hx.insert(r1)
hx.insert(r2)
hx.insert(r3)
hx.insert(r4)

user_ai = AI.new(hx, "computer", "user")
p user_ai.enemy_tendency?("rock", 0.5)

puts "-------------------------------"

p user_ai.percent_loss("lizard")

puts "-------------------------------"

user_ai.enemy_next_likely?("rock", 2, 3)