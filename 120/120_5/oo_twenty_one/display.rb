require_relative 'util'
require 'pry'

class Display
  attr_reader :human, :dealer
  SUIT_SYMBOLS = {
    'spades' => "\xe2\x99\xa0",
    'diamonds' => "\xe2\x99\xa6",
    'clubs' => "\xe2\x99\xa3",
    'hearts' => "\xe2\x99\xa5"
  }.freeze

  def initialize(human, dealer)
    @human = human
    @dealer = dealer
  end

  def draw_card(card)
    space = ' '
    space = '' if card.face_value == '10'

    lines = []
    lines << "┌─────────┐"
    lines << "|#{card.face_value}#{space}       |"
    lines << "|         |"
    lines << "|         |"
    lines << "|    #{SUIT_SYMBOLS[card.suit]}    |"
    lines << "|         |"
    lines << "|         |"
    lines << "|       #{card.face_value}#{space}|"
    lines << "└─────────┘"
    lines
  end

  def draw_card_back
    shaded_row = []
    9.times { shaded_row << "\xe2\x96\x92" }
    shading = shaded_row.join
    lines = []
    lines << "┌─────────┐"
    7.times { lines << "|" + shading + "|" }
    lines << "└─────────┘"
    lines
  end

  def draw_hand(graphic_cards_list)
    rows = []
    9.times do |num|
      rows << Array.new(graphic_cards_list.map { |card| card[num] })
    end

    rows.each do |row|
      display_row = ""
      row.each { |card_piece| display_row += card_piece.ljust(12) }
      puts display_row
    end
  end

  def show_hand_to_console(player)
    display_cards = []
    player.hand.each do |card|
      display_cards << draw_card(card)
    end

    if player.class == Dealer && player.active_turn == false
      mystery_cards = []
      display_cards.count.times { mystery_cards << draw_card_back }
      first_card = display_cards.first
      display_cards = mystery_cards
      display_cards[0] = first_card
    end
    draw_hand(display_cards)
  end

  def clear_screen
    system("clear") || system("cls")
  end

  def dealer_stats
    str = "#{dealer.name}'s Hand Value: "
    str += dealer.active_turn ? "#{dealer.hand_value}\n" : "???\n"
    str += "#{dealer.name}'s Overall Score: #{dealer.score}\n\n"
    str
  end

  def show_dealer_info
    puts "#{dealer.name}'s Hand:"
    show_hand_to_console(dealer)
    puts "\n"
    puts dealer_stats
  end

  def show_human_info
    puts "#{human.name}'s Hand:"
    show_hand_to_console(human)
    puts "\n#{human.name}'s Hand Value: #{human.hand_value}\n"
    puts "#{human.name}'s Overall Score: #{human.score}\n\n"
  end

  def refresh_screen
    clear_screen
    puts "---------------------------------------------------"
    puts "Mega #{human.winning_value} Extravaganza".center(50)
    puts "---------------------------------------------------\n\n"
    show_dealer_info
    show_human_info
    puts "---------------------------------------------------\n\n"
  end
end
