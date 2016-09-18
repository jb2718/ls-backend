# frozen_string_literal: true
require_relative 'util'
require_relative 'display'
require_relative 'deck'
require_relative 'player'
require_relative 'validations'
require 'pry'

class Game
  include Utilities::Console
  include MoreValidations

  attr_accessor :user, :computer, :game_deck
  attr_reader :table
  WINNING_VALUE = 21
  DEALER_MAX = 17
  MAX_SCORE = 5

  def initialize
    @user = Player.new(WINNING_VALUE)
    @computer = Dealer.new(WINNING_VALUE, DEALER_MAX)
    @game_deck = []
    @table = Display.new(user, computer)
  end

  private

  def setup
    self.game_deck = Deck.new
    2.times { user.hand << game_deck.deal_card }
    2.times { computer.hand << game_deck.deal_card }
    table.refresh_screen
  end

  def reset_game
    user.reset_hand
    computer.reset_hand
    if user.score == MAX_SCORE || computer.score == MAX_SCORE
      user.reset_score
      computer.reset_score
    end
    setup
  end

  def toggle_turn(active_player)
    if active_player.class == Player
      user.active_turn = true
      computer.active_turn = false
    else
      computer.active_turn = true
      user.active_turn = false
    end
  end

  def human_hit_routine(user_input)
    if valid_hit?(user_input)
      user.hit(game_deck.deal_card)
      table.refresh_screen
      prompt "You chose to hit! Updating hand..."
    else
      prompt "That is not a valid entry.  Please try again!"
    end
  end

  def human_hit_or_stay_loop
    loop do
      break if user.busted?
      prompt "#{user.name}, do you want to [h]it or [s]tay?"
      answer = gets.chomp
      break if valid_stay?(answer)
      human_hit_routine(answer)
      sleep(1)
    end
  end

  def human_turn
    toggle_turn(user)
    table.refresh_screen
    human_hit_or_stay_loop
    if user.busted?
      prompt "Sorry #{user.name}, you busted! Ending round..."
    else
      prompt "#{user.name} chose to stay!"
    end
    sleep(2)
  end

  def computer_hit_loop
    loop do
      break if computer.maxed?
      computer.hit(game_deck.deal_card)
      table.refresh_screen
      prompt "#{computer.name} chooses to hit..."
      sleep(2)
    end
  end

  def computer_turn
    toggle_turn(computer)
    table.refresh_screen
    prompt "#{computer.name}'s turn..."
    computer_hit_loop
    if computer.busted?
      prompt "#{computer.name} busted!"
    else
      prompt "#{computer.name} stays!"
    end
    sleep(2)
  end

  def play_again?
    answer = ''
    loop do
      puts "---------------------------------------------------"
      prompt "Would you like to play again? [Y]es/[N]o"
      answer = gets.chomp

      case answer.downcase
      when 'y', 'yes'
        return true
      when 'n', 'no'
        return false
      else
        prompt "#{answer} is an invalid response"
      end
    end
  end

  def determine_results
    if user.busted?
      :pbust
    elsif computer.busted?
      :dbust
    elsif user.hand_value > computer.hand_value
      :player
    elsif computer.hand_value > user.hand_value
      :dealer
    end
  end

  def show_game_winner
    if user.score == MAX_SCORE
      prompt "#{user.name} won the game!"
    elsif computer.score == MAX_SCORE
      prompt "#{computer.name} won the game!"
    end
  end

  def print_winner(result)
    case result
    when :dbust, :player
      prompt "#{user.name} won!"
    when :pbust, :dealer
      prompt "#{computer.name} won!"
    else
      prompt "Tie game!"
    end
    show_game_winner
  end

  def update_score(result)
    case result
    when :pbust, :dealer
      computer.add_point
    when :dbust, :player
      user.add_point
    end
  end

  public

  def play
    loop do
      reset_game
      human_turn
      computer_turn unless user.busted?
      result = determine_results
      update_score(result)
      print_winner(result)
      break unless play_again?
    end
    prompt "Thanks for playing!  See you next time :)"
  end
end

card_game = Game.new
card_game.play
