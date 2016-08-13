require 'pry'

class Rock
  attr_reader :value
  def initialize
    @value = 'rock'
  end

  def beats?(other_move)
    return true if ['lizard', 'scissors'].include?(other_move.value)
    false
  end

  def defeated_by?(other_move)
    return true if ['spock', 'paper'].include?(other_move.value)
    false
  end
end

class Paper
  attr_reader :value
  def initialize
    @value = 'paper'
  end

  def beats?(other_move)
    return true if ['rock', 'spock'].include?(other_move.value)
    false
  end

  def defeated_by?(other_move)
    return true if ['scissors', 'lizard'].include?(other_move.value)
    false
  end
end

class Scissors
  attr_reader :value
  def initialize
    @value = 'scissors'
  end

  def beats?(other_move)
    return true if ['paper', 'lizard'].include?(other_move.value)
    false
  end

  def defeated_by?(other_move)
    return true if ['rock', 'spock'].include?(other_move.value)
    false
  end
end

class Lizard
  attr_reader :value
  def initialize
    @value = 'lizard'
  end

  def beats?(other_move)
    return true if ['paper', 'spock'].include?(other_move.value)
    false
  end

  def defeated_by?(other_move)
    return true if ['scissors', 'rock'].include?(other_move.value)
    false
  end
end

class Spock
  attr_reader :value
  def initialize
    @value = 'paper'
  end

  def beats?(other_move)
    return true if ['rock', 'scissors'].include?(other_move.value)
    false
  end

  def defeated_by?(other_move)
    return true if ['paper', 'lizard'].include?(other_move.value)
    false
  end
end

class Move
  VALUES = %w(rock paper scissors lizard spock).freeze
  attr_reader :value

  def initialize(user_choice)
    @value = user_choice
    @choice = convert_input(@value)
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

  def lizard?
    @value == 'lizard'
  end

  def spock?
    @value == 'spock'
  end

  def convert_input(choice)
    if rock?
      Rock.new
    elsif paper?
      Paper.new
    elsif scissors?
      Scissors.new
    elsif lizard?
      Lizard.new
    elsif spock?
      Spock.new
    end  
  end

  def >(other_move)
    @choice.beats?(other_move)
  end

  def <(other_move)
    @choice.defeated_by?(other_move)
  end

  def to_s
    @value
  end
end