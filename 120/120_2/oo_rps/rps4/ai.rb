require 'pry'
require './history.rb'

VALUES = %w(rock paper scissors lizard spock).freeze

class AI
  # This class does ai processing based on a history of moves
  # and a set of preferences.  It tells the caller which move
  # to pick.

  # INPUT: most recent history, preferences for a particular personality,
  #        access to list of valid moves
  # OUTPUT: a string representation of one of the valid move choices

  def initialize(history, enemy, protagonist, prefs)
    @game_hx = history
    @enemy = enemy
    @protagonist = protagonist
    @prefs = prefs
    @num_rounds = @game_hx.length
  end

  def last_n_rounds(num)
    return [] if num > @num_rounds
    start = (@num_rounds - num)
    arr = []
    (start...@num_rounds).each do |idx|
      arr.push(@game_hx[idx])
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
    VALUES.each do |move|
      num_rounds = @prefs[:streak_window]
      num_in_row = @prefs[:streak_length]
      return move if streak?(move, num_rounds, num_in_row)
    end
    nil
  end

  def enemy_tendency?(move)
    return false if @num_rounds == 0
    total_times_chosen = @game_hx.find_by(@enemy, move).count
    percentage_chosen = total_times_chosen.to_f / @num_rounds.to_f
    return true if percentage_chosen > @prefs[:tendency_threshhold]
    false
  end

  def overall_enemy_tendency
    VALUES.each do |move|
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
    arr = Array.new(VALUES)
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
