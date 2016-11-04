# frozen_string_literal: true
require_relative 'card'

class Hand
  attr_accessor :point_total, :cards
  def initialize
    @point_total = 0
    @cards = []
  end

  def update_point_total
    sum = 0
    non_ace_cards = cards.select { |card| card.face_value != 'A' }
    aces = cards.select { |card| card.face_value == 'A' }

    non_ace_cards.each { |card| sum += card.num_value }
    aces.each do |card|
      sum += if sum >= 11
               1
             else
               card.num_value
             end
    end
    self.point_total = sum
  end

  def add(card)
    cards << card
    update_point_total
  end

  def <<(card)
    cards << card
    update_point_total
  end

  def reset
    self.point_total = 0
    self.cards = []
  end

  def each
    counter = 0
    loop do
      break if counter == cards.count
      yield(cards[counter])
      counter += 1
    end
    cards
  end
end
