def create_deck
  suits = ['spades', 'hearts', 'clubs', 'diamonds']
  values = [
    '2', '3', '4', '5',
    '6', '7', '8', '9',
    '10', 'J', 'Q', 'K',
    'A'
  ]
  suits.product(values)
end

def deal_card(deck)
  card = deck.sample
  deck.delete(card)
  card
end

def get_value(card)
  card_vals = {
    '1' => 1, '2' => 2, '3' => 3,
    '4' => 4, '5' => 5, '6' => 6,
    '7' => 7, '8' => 8, '9' => 9,
    '10' => 10, 'J' => 10, 'Q' => 10,
    'K' => 10, 'A' => 11
  }
  card_vals[card.last]
end
