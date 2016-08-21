require './ai.rb'
require './score.rb'

class Player
  attr_accessor :name, :move, :score

  def initialize
    @score = Score.new
    set_name
  end

  def display_score
    coda = @score.value == 1 ? "point" : "points"
    puts "#{self.name} has #{@score} #{coda}."
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
  attr_reader :name, :enemy_tendency_threshhold, :enemy_moves_in_a_row_window, :num_enemy_moves_in_a_row, :max_percent_loss
  def initialize
    @name = ['Number 5', 'R2D2', 'Eve', 'Wall-E'].sample
    @enemy_tendency_threshhold = 0
    @max_percent_loss = 0
    @enemy_moves_in_a_row_window = 0
    @num_enemy_moves_in_a_row = 0
  end

  def define_preferences
    case self.name
    when 'Number 5'
      @enemy_tendency_threshhold = 0.5
      @max_percent_loss = 0.4
      @enemy_moves_in_a_row_window = 5
      @num_enemy_moves_in_a_row = 3      
    when 'R2D2'
      @enemy_tendency_threshhold = 0.25
      @max_percent_loss = 0.2
      @enemy_moves_in_a_row_window = 10
      @num_enemy_moves_in_a_row = 5      
    when 'Eve'
      @enemy_tendency_threshhold = 0.33
      @max_percent_loss = 0.33
      @enemy_moves_in_a_row_window = 5
      @num_enemy_moves_in_a_row = 2      
    when 'Wall-E'
      @enemy_tendency_threshhold = 0.6
      @max_percent_loss = 0.25
      @enemy_moves_in_a_row_window = 8
      @num_enemy_moves_in_a_row = 3 
    end     
  end
end

class Computer < Player
  def initialize(history)
    @computer_ai = AI.new(history,'user','computer')
    @comp_personality = Personality.new
    @comp_personality.define_preferences
    super()
  end

  def set_name
    @name = @comp_personality.name
  end

  def next_move_in_row
    is_likely = false
    likely_move = nil
    Move::VALUES.each do |move|
      is_likely = @computer_ai.enemy_next_likely?(move, @comp_personality.num_enemy_moves_in_a_row, @comp_personality.enemy_moves_in_a_row_window)
      if is_likely
        likely_move = move
        break
      end
    end
    likely_move
  end

  def beat_enemy_tendency
    is_tendency = false
    defense_move = nil
    Move::VALUES.each do |move|
      is_tendency = @computer_ai.enemy_tendency?(move, @comp_personality.enemy_tendency_threshhold)
      if is_tendency
        defense_move = @computer_ai.opposing_move(move)
        break
      end
    end
    defense_move
  end

  def check_my_tendency
    move = Move::VALUES.sample
    return move if @computer_ai.percent_loss(move) > @comp_personality.max_percent_loss
    @computer_ai.opposing_move(move)
  end

  def choose
    ai_move = ''

    next_move = nil
    next_move = next_move_in_row
    if next_move
      ai_move = next_move
    elsif beat_enemy_tendency
      ai_move = beat_enemy_tendency
    else
      ai_move = check_my_tendency
    end
    @move = Move.new(ai_move)
    puts "#{@name} chose: #{@move}"
  end
end