# frozen_string_literal: true
require_relative 'card'

class Deck
  attr_accessor :cards
  def initialize
    @cards = []
    create_card_deck
  end

  private

  def create_card_deck
    suits = ['spades', 'hearts', 'clubs', 'diamonds']
    values = [
      '2', '3', '4', '5',
      '6', '7', '8', '9',
      '10', 'J', 'Q', 'K',
      'A'
    ]
    suits.product(values).each do |card_text|
      cards << Card.new(card_text[0], card_text[1])
    end
  end

  public

  def deal_card
    card = cards.sample
    cards.delete(card)
    card
  end
end
