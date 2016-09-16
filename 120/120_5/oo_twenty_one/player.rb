require_relative 'hand'
require_relative 'util'

class Player
  include Utility
  attr_accessor :name, :busted, :score, :hand, :active_turn
  attr_reader :winning_value
  def initialize(winning_value)
    @name = set_name
    @busted = false
    @score = 0
    @hand = Hand.new
    @winning_value = winning_value
    @active_turn = false
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

  def hit(card)
    hand << card
    self.busted = true if hand.point_total > winning_value
  end

  def busted?
    busted
  end

  def reset_hand
    hand.reset
    self.busted = false
  end

  def reset_score
    @score = 0
  end

  def hand_value
    hand.point_total
  end

  def add_point
    self.score += 1
  end
end

class Dealer < Player
  attr_reader :hit_max
  def initialize(winning_value, max)
    super(winning_value)
    @hit_max = max
  end

  def set_name
    ["Monte Carlo", "Caesar's Palace", "Bellagio", "Palms", "MGM Grand"].sample
  end

  def maxed?
    hand.point_total >= hit_max
  end
end
