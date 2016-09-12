require_relative 'board'
require_relative 'player'
require_relative 'util'

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
    @messaging = set_game_stats
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
    case first_turn
    when :user
      user
    when :computer
      computer
    else
      choose_first_player
    end
  end

  def set_game_stats
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
    if @current_player == user
      player_turn
    else
      computer_turn
    end
    alternate_turn
  end

  def alternate_turn
    @current_player = if @current_player == user
                        computer
                      else
                        user
                      end
  end

  def clear_screen
    system("clear") || system("cls")
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
    self.messaging = set_game_stats
    messaging[0] = "Let's play again!"
    board.clear
    @current_player = first_to_go
  end

  def draw_banner
    str = "=" * 50
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
      break if board.open_moves.include?(choice)
      prompt("Your entry is invalid.  Please try again!")
    end
    board[choice] = user.mark
    draw_board
  end

  def select_computer_option(offensive_move, defensive_move, open_moves)
    if offensive_move
      offensive_move
    elsif defensive_move
      defensive_move
    elsif open_moves.include?(5)
      5
    else
      open_moves.sample
    end
  end

  def computer_choice
    open_moves = board.open_moves
    cpu_moves = board.all_moves_of_type(computer.mark)
    user_moves = board.all_moves_of_type(user.mark)
    offensive_move = computer.next_move(cpu_moves, open_moves)
    defensive_move = computer.next_move(user_moves, open_moves)

    select_computer_option(offensive_move, defensive_move, open_moves)
  end

  def computer_turn
    choice = computer_choice
    board[choice] = computer.mark
    draw_board
  end

  def winner
    if board.won?(user.mark)
      return :user
    elsif board.won?(computer.mark)
      return :computer
    end
    nil
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

  def show_score
    prompt "#{user.name}'s New Score: #{user.score}"
    prompt "#{computer.name}'s New Score: #{computer.score}"
  end

  def show_game_winner
    if user.score == MAX_SCORE
      prompt "#{user.name} won the game!"
    elsif computer.score == MAX_SCORE
      prompt "#{computer.name} won the game!"
    end
  end

  def display_result
    case winner
    when :user
      prompt "#{user.name} won this round!"
    when :computer
      prompt "#{computer.name} won this round!"
    else
      prompt "Tie!"
    end
    show_game_winner
    show_score
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
