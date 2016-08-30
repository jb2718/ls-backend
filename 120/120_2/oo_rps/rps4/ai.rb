require 'pry'
require './history.rb'
require './move.rb'

class AI
  # This class does ai processing based on a history of moves
  # and a set of preferences.

  def initialize(history, enemy, protagonist, prefs)
    @game_history = history
    @enemy = enemy
    @protagonist = protagonist
    @prefs = prefs
  end

  def last_n_rounds(num)
    return [] if num > @game_history.length
    start = (@game_history.length - num)
    arr = []
    (start...@game_history.length).each do |idx|
      arr.push(@game_history[idx])
    end
    arr
  end

  def streak?(move, num_rounds, num_in_row)
    return false if num_in_row > num_rounds
    counter = 0
    streaks = []
    last_n_rounds(num_rounds).each do |record|
      if record[@enemy.to_sym] == move
        counter += 1
      else
        streaks << counter
        counter = 0
      end
      streaks << counter
    end

    return true if !streaks.max.nil? && streaks.max >= num_in_row
    false
  end

  def enemy_streak
    Move::VALUES.each do |move|
      num_rounds = @prefs[:streak_window]
      num_in_row = @prefs[:streak_length]
      return move if streak?(move, num_rounds, num_in_row)
    end
    nil
  end

  def enemy_tendency?(move)
    return false if @game_history.length == 0
    total_times_chosen = @game_history.find_by(@enemy, move).count
    percentage_chosen = total_times_chosen.to_f / @game_history.length.to_f
    return true if percentage_chosen > @prefs[:tendency_threshhold]
    false
  end

  def overall_enemy_tendency
    Move::VALUES.each do |move|
      return move if enemy_tendency?(move)
    end
    nil
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

  def preferred_moves(move)
    arr = Array.new(Move::VALUES)
    3.times { arr << move }
    arr
  end

  def calculate_next_move
    streak_move = enemy_streak
    return opposing_move(streak_move) if streak_move

    tendency_move = overall_enemy_tendency
    return opposing_move(tendency_move) if tendency_move

    preferred_moves(@prefs[:favorite_move]).sample
  end
end
