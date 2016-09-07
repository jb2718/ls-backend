require 'pry'
require './board.rb'
require './player.rb'
require './util.rb'

class Game
  attr_accessor :board, :user, :computer, :messaging, :first_turn
  MAX_SCORE = 5
  WHO_GOES_FIRST = :choice # :user, :computer, or :choice
  def initialize
    draw_banner
    @board = Board.new
    @user = Player.new
    @computer = Computer.new
    @first_turn = WHO_GOES_FIRST
    @current_player = first_to_go
    @messaging = set_start_message
  end

  private
  def choose_first_player
    loop do
      prompt "Choose who goes first. [U]ser or [C]omputer?"
      choice = gets.chomp
      choice.downcase!
      if choice == 'u' || choice == 'user'
        self.first_turn = :user
        return user
      elsif choice == 'c' || choice == 'computer'
        self.first_turn = :computer
        return computer
      else
        prompt "That choice is not valid. Please try again!"
      end
    end
  end

  def first_to_go
    case self.first_turn
    when :user
      self.first_turn = :user
      user
    when :computer
      self.first_turn = :computer
      computer
    else
      choose_first_player
    end 
  end

  def set_start_message
    messages = ["Welcome to Tic Tac Toe!"]
    [user, computer].each do |player|
      msg = "#{player.name}'s Mark: #{player.mark}".ljust(20)
      msg += "|"
      msg += " #{player.name}'s Score: #{player.score}"
      messages << msg
    end
    messages
  end

  def current_player_turn
    if @current_player.mark == user.mark
      player_turn
    else
      computer_turn
    end
    alternate_turn
  end

  def alternate_turn
    @current_player = if @current_player.mark == user.mark
                        computer
                      else
                        user
                      end
  end

  def clear_screen
    system "clear"
  end

  def draw_board
    clear_screen
    draw_banner
    messaging.each { |msg| prompt(msg) }
    board.draw(15)
  end

  def reset_game
    user.reset_score
    computer.reset_score
    self.first_turn = WHO_GOES_FIRST
  end

  def reset_board
    if user.score == MAX_SCORE || computer.score == MAX_SCORE
      reset_game
    end
    self.messaging = set_start_message
    self.messaging[0] = "Let's play again!"
    board.clear
    @current_player = first_to_go
  end

  def draw_banner
    str = ''
    50.times { str << "=" }
    puts str
    puts "Tic Tac Toe".center(50)
    puts str
  end

  def player_turn
    choice = ''
    loop do
      prompt("Choose your next move: ")
      prompt("Available Moves: #{joinor(board.open_moves, ', ')}")
      choice = gets.chomp.to_i
      if board.open_moves.include?(choice)
        break
      else
        prompt("Your entry is invalid.  Please try again!")
      end
    end
    board[choice] = user.mark
    draw_board
  end

  def computer_turn
    cpu_moves = board.all_moves_of_type(computer.mark)
    offensive_move = computer.next_move(cpu_moves)
    user_moves = board.all_moves_of_type(user.mark)
    defensive_move = computer.next_move(user_moves)

    choice = if offensive_move && board.open_moves.include?(offensive_move)
              offensive_move 
             elsif defensive_move && board.open_moves.include?(defensive_move)
              defensive_move
             elsif board.open_moves.include?(5)
              5
             else
              board.open_moves.sample
             end  

    board[choice] = computer.mark
    draw_board
  end

  def winner
    if board.won?(user.mark)
      :user
    elsif board.won?(computer.mark)
      :computer
    else
      nil
    end
  end

  def play_again?
    choice = ''
    loop do
      prompt("Would you like to play again? [Y]es or [N]o")
      choice = gets.chomp
      case choice.downcase
      when 'y', 'yes'
        return true
      when 'n', 'no'
        return false
      else
        prompt("Your entry is invalid.  Please try again!")
      end
    end
  end

  def update_score
    case winner
    when :user
      user.add_point
    when :computer
      computer.add_point
    end
  end

  def display_result
    case winner
    when :user
      prompt "#{user.name} won this round!"
      prompt "#{user.name} won the game!" if user.score == 5
    when :computer
      prompt "#{computer.name} won this round!"
      prompt "#{computer.name} won the game!" if computer.score == 5
    else
      prompt "Tie!"
    end
    prompt "#{user.name}'s New Score: #{user.score}"
    prompt "#{computer.name}'s New Score: #{computer.score}"
  end

  public

  def play
    loop do
      loop do
        draw_board
        current_player_turn
        break if winner || board.full?
      end
      update_score
      display_result
      break unless play_again?
      reset_board
    end
    prompt("Thanks for playing Tic Tac Toe! Goodbye!")
  end
end

TTT_game = Game.new
TTT_game.play
