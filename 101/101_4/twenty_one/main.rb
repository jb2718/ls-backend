require './util.rb'
require './deck.rb'
require 'pry'

WINNING_VALUE = 21
DEALER_MAX = 17
CARD_STYLE = :text # :text or :graphic

def display_text_hand(player)
  display_text = []
  player[:hand].each do |card|
    display_text << "#{card.last} of #{card.first.capitalize}"
  end
  if player[:name] == 'dealer' && player[:my_turn] == false
    mystery_arr = []
    display_text.count.times { mystery_arr << "[?]" }
    first_card = display_text.first
    display_text = mystery_arr
    display_text[0] = first_card
  end
  puts joinor(display_text, ', ', 'and')
end

def display_graphic_hand(player)
  display_cards = []
  player[:hand].each do |card|
    display_cards << draw_card(card)
  end
  if player[:name] == 'dealer' && player[:my_turn] == false
    mystery_cards = []
    display_cards.count.times { mystery_cards << draw_card_back }
    first_card = display_cards.first
    display_cards = mystery_cards
    display_cards[0] = first_card
  end
  draw_hand(display_cards)
end

def show_hand(player)
  case CARD_STYLE
  when :text
    display_text_hand(player)
  when :graphic
    display_graphic_hand
  end
end

def show_table(player, dealer)
  system "clear"
  puts "---------------------------------------------------"
  puts "Crazy Al's #{WINNING_VALUE} Bonanza".center(50)
  puts "---------------------------------------------------\n\n"
  puts "Dealer's Hand:"
  show_hand(dealer)
  if player[:my_turn] == false
    puts "Dealer's Points: #{dealer[:hand_value]}\n\n"
  else
    puts "\n\n"
  end

  puts "Your Hand:"
  show_hand(player)
  puts "Your Points: #{player[:hand_value]}\n\n"
  puts "---------------------------------------------------\n\n"
end

def update_hand_value(player)
  sum = 0
  non_ace_cards = player[:hand].select { |card| card.last != 'A' }
  aces = player[:hand].select { |card| card.last == 'A' }

  non_ace_cards.each { |card| sum += get_value(card) }
  aces.each do |card|
    sum += if sum >= 11
             1
           else
             get_value(card)
           end
  end
  player[:hand_value] = sum
end

def hit(player, deck)
  player[:hand] << deal_card(deck)
  update_hand_value(player)
end

def busted?(score)
  score > WINNING_VALUE
end

def setup_game(deck, player, dealer)
  2.times { hit(player, deck) }
  2.times { hit(dealer, deck) }
end

def valid_stay?(response)
  case response.downcase
  when 's', 'stay'
    true
  end
end

def valid_hit?(response)
  case response.downcase
  when 'h', 'hit'
    true
  end
end

def switch_board_control(turn_on, turn_off)
  turn_on[:my_turn] = true
  turn_off[:my_turn] = false
end

def player_actions(player, dealer, deck)
  loop do
    show_table(player, dealer)
    prompt "Do you want to [h]it or [s]tay?"
    answer = gets.chomp
    break if valid_stay?(answer) || busted?(player[:hand_value])
    if valid_hit?(answer)
      hit(player, deck)
      prompt "You chose to hit! Updating hand..."
    else
      prompt "That is not a valid entry.  Please try again!"
    end
    sleep(1)
    next unless busted?(player[:hand_value])
    break
  end
end

def player_turn(player, dealer, deck)
  player_actions(player, dealer, deck)

  if busted?(player[:hand_value])
    player[:busted_flag] = true
    show_table(player, dealer)
    prompt "Sorry, you busted! Ending round..."
  else
    prompt "You chose to stay!"
  end
  sleep(2)
end

def dealer_turn(player, dealer, deck)
  loop do
    show_table(player, dealer)
    prompt "Dealer's turn..."
    break if dealer[:hand_value] >= DEALER_MAX
    prompt "Dealer chooses to hit..."
    hit(dealer, deck)
    sleep(2)
  end
  if busted?(dealer[:hand_value])
    dealer[:busted_flag] = true
    prompt "Dealer busted!"
  else
    prompt "Dealer stays!"
  end
  sleep(2)
end

def determine_winner(player, dealer)
  if player[:busted_flag] == true
    "pbust"
  elsif dealer[:busted_flag] == true
    "dbust"
  elsif player[:hand_value] == dealer[:hand_value]
    "tie"
  elsif player[:hand_value] > dealer[:hand_value]
    "player"
  elsif dealer[:hand_value] > player[:hand_value]
    "dealer"
  end
end

def display_winner(result)
  case result
  when "pbust"
    prompt "Dealer won because you busted!"
  when "dbust"
    prompt "You won because the dealer busted!"
  when "player"
    prompt "You won!"
  when "dealer"
    prompt "Dealer won!"
  when "tie"
    prompt "Tie game!"
  end
end

def update_score(player, dealer, result)
  case result
  when "pbust", "dealer"
    dealer[:game_score] += 1
  when "dbust", "player"
    player[:game_score] += 1
  end
end

def show_score(player, dealer)
  prompt "Player Points: #{player[:game_score]}"
  prompt "Dealer Points: #{dealer[:game_score]}"
  prompt "End of Round..."

  if player[:game_score] == 5
    prompt "You scored 5 points first and won the whole game!"
  elsif dealer[:game_score] == 5
    prompt "The dealer scored 5 points first and won the whole game!"
  end
end

def reset_hand(player)
  player[:hand_value] = 0
  player[:hand] = []
  player[:busted_flag] = false
  player[:my_turn] = false
end

def complete_reset(player)
  player[:game_score] = 0
  player[:hand_value] = 0
  player[:hand] = []
  player[:busted_flag] = false
  player[:my_turn] = false
end

player = {
  name: "player",
  game_score: 0,
  hand: [],
  hand_value: 0,
  busted_flag: false,
  my_turn: false
}

dealer = {
  name: "dealer",
  game_score: 0,
  hand: [],
  hand_value: 0,
  busted_flag: false,
  my_turn: false
}

loop do
  # initialize new hand
  game_deck = create_deck
  reset_hand(player)
  reset_hand(dealer)
  setup_game(game_deck, player, dealer)
  switch_board_control(player, dealer)

  # play game
  player_turn(player, dealer, game_deck)
  switch_board_control(dealer, player)
  dealer_turn(player, dealer, game_deck) unless player[:busted_flag]

  show_table(player, dealer)
  winner = determine_winner(player, dealer)
  display_winner(winner)

  update_score(player, dealer, winner)
  show_score(player, dealer)

  if player[:game_score] == 5 || dealer[:game_score] == 5
    complete_reset(player)
    complete_reset(dealer)
  end

  break unless play_again?
end # end main game loop

prompt "Thanks for playing!  See you next time :)"
