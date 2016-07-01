require './util.rb'
require './deck.rb'
require 'pry'

WINNING_VALUE = 21
DEALER_MAX = 17

player = {
  game_score: 0,
  hand: [],
  hand_value: 0,
  busted_flag: false
}

dealer = {
  game_score: 0,
  hand: [],
  hand_value: 0,
  busted_flag: false
}

def show_table(player, dealer)
  system "clear"
  puts "---------------------------------------------------"
  puts "Crazy Al's #{WINNING_VALUE} Bonanza".center(50)
  puts "---------------------------------------------------\n\n"
  puts "Dealer's Hand: #{dealer[:hand]} || Points: #{dealer[:hand_value]}\n\n"
  puts "Your Hand: #{player[:hand]} || Points: #{player[:hand_value]}\n\n"
  puts "---------------------------------------------------\n\n"
end

def update_hand_value(player)
  sum = 0
  player[:hand].each do |card|
    sum += if sum >= 11 && card.last == 'A'
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

# rubocop:disable Performance/Casecmp
def valid_stay?(response)
  response.downcase == 's' || response.downcase == 'stay'
end

def valid_hit?(response)
  response.downcase == 'h' || response.downcase == 'hit'
end
# rubocop:enable Performance/Casecmp

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
  when "pbust"
    dealer[:game_score] += 1
  when "dbust"
    player[:game_score] += 1
  when "player"
    player[:game_score] += 1
  when "dealer"
    dealer[:game_score] += 1
  when "tie"
    # nobody gains points when there's a tie
  end
end

def reset_hand(player)
  player[:hand_value] = 0
  player[:hand] = []
  player[:busted_flag] = false
end

def complete_reset(player)
  player[:game_score] = 0
  player[:hand_value] = 0
  player[:hand] = []
  player[:busted_flag] = false
end

loop do
  # initialize new hand
  game_deck = create_deck
  reset_hand(player)
  reset_hand(dealer)
  setup_game(game_deck, player, dealer)

  # play game
  # player's turn
  loop do
    show_table(player, dealer)
    prompt "Do you want to [h]it or [s]tay?"
    answer = gets.chomp
    break if valid_stay?(answer) || busted?(player[:hand_value])
    if valid_hit?(answer)
      hit(player, game_deck)
      prompt "You chose to hit!"
      prompt "Current Hand: #{player[:hand]} || Points: #{player[:hand_value]}"
    else
      prompt "That is not a valid entry.  Please try again!"
    end
    next unless busted?(player[:hand_value])
    player[:busted_flag] = true
    prompt "Sorry, you busted!"
  end
  prompt "You chose to stay!" unless player[:busted_flag]

  # dealer's turn
  unless player[:busted_flag]
    loop do
      show_table(player, dealer)
      prompt "Dealer's turn..."
      break if dealer[:hand_value] >= DEALER_MAX
      prompt "Dealer chooses to hit..."
      hit(dealer, game_deck)
      prompt "Dealer's Hand: #{dealer[:hand]} || Points: #{dealer[:hand_value]}"
    end
    if busted?(dealer[:hand_value])
      dealer[:busted_flag] = true
      prompt "Dealer busted!"
    else
      prompt "Dealer stays!"
    end
  end

  show_table(player, dealer)
  winner = determine_winner(player, dealer)
  display_winner(winner)

  update_score(player, dealer, winner)
  prompt "Player Points: #{player[:game_score]}"
  prompt "Dealer Points: #{dealer[:game_score]}"
  prompt "End of Round..."

  if player[:game_score] == 5
    prompt "You scored 5 points first and won the whole game!"
    complete_reset(player)
    complete_reset(dealer)
  elsif dealer[:game_score] == 5
    prompt "The dealer scored 5 points first and won the whole game!"
    complete_reset(player)
    complete_reset(dealer)
  end

  answer = ''
  loop do
    puts "--------------------------------------------"
    prompt "Would you like to play again? [Y]es/[N]o"
    answer = gets.chomp
    break unless play_again?(answer) < 0
    prompt "#{answer} is an invalid response"
  end
  break unless play_again?(answer) == 1
end

prompt "Thanks for playing!  See you next time :)"
