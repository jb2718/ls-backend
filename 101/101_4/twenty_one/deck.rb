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

def draw_card(card)
  symbol_table = {
    'spades' => "\xe2\x99\xa0",
    'diamonds' => "\xe2\x99\xa6",
    'clubs' => "\xe2\x99\xa3",
    'hearts' => "\xe2\x99\xa5"
  }

  space = ' '
  space = '' if card.last == '10' 

  lines = []
  lines << "┌─────────┐"
  lines << "|#{card.last}#{space}       |"
  lines << "|         |"
  lines << "|         |"
  lines << "|    #{symbol_table[card.first]}    |"
  lines << "|         |"
  lines << "|         |"
  lines << "|       #{card.last}#{space}|"
  lines << "└─────────┘"
  lines
end

def draw_card_back
  shaded_row = []
  9.times {shaded_row << "\xe2\x96\x92"}
  shading = shaded_row.join
  lines = []
  lines << "┌─────────┐"
  7.times{ lines << "|" + shading + "|"}
  lines << "└─────────┘"
  lines
end