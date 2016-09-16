class Card
  attr_accessor :suit, :face_value, :num_value
  def initialize(suit, value)
    @suit = suit
    @face_value = value
    @num_value = set_num_value
  end

  def set_num_value
    card_vals = {
      '1' => 1, '2' => 2, '3' => 3,
      '4' => 4, '5' => 5, '6' => 6,
      '7' => 7, '8' => 8, '9' => 9,
      '10' => 10, 'J' => 10, 'Q' => 10,
      'K' => 10, 'A' => 11
    }
    card_vals[face_value]
  end
end
