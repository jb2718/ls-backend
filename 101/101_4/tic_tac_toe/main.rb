require 'pry'

PLAYER_MARK = 'X'.freeze
COMPUTER_MARK = 'O'.freeze
EMPTY_SQUARE_MARK = '*'.freeze
WINNING_COMBOS = [
  [1, 2, 3], [4, 5, 6], [7, 8, 9],
  [1, 4, 7], [2, 5, 8], [3, 6, 9],
  [1, 5, 9], [3, 5, 7]
].freeze

# rubocop:disable Performance/Casecmp
def play_again?(response)
  if response.downcase == 'y' || response.downcase == 'yes'
    return 1
  elsif response.downcase == 'n' || response.downcase == 'no'
    return 0
  else
    return -1
  end
end
# rubocop:enable Performance/Casecmp

def valid_move?(move, board)
  board.include?(move)
end

def prompt(message)
  puts "=> #{message}"
end

def winner?(moves)
  WINNING_COMBOS.each do |combo|
    marks_in_a_row = 0
    combo.each do |number|
      break unless moves.include?(number)
      marks_in_a_row += 1
    end
    return true if marks_in_a_row == 3
  end
  false
end

def tie?(brd)
  brd[:empty_squares].empty?
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  system "clear"
  puts "Welcome to Tic-Tac-Toe"
  prompt "You are #{PLAYER_MARK}'s."
  prompt "Computer is #{COMPUTER_MARK}'s.\n\n"
  squares = []
  9.times { squares << EMPTY_SQUARE_MARK }
  brd[:player_moves].each { |square| squares[square - 1] = PLAYER_MARK }
  brd[:computer_moves].each { |square| squares[square - 1] = COMPUTER_MARK }
  row1 = squares[0].ljust(6) + squares[1].ljust(6) + squares[2]
  row2 = squares[3].ljust(6) + squares[4].ljust(6) + squares[5]
  row3 = squares[6].ljust(6) + squares[7].ljust(6) + squares[8]
  puts row1.center(30)
  puts row2.center(30)
  puts row3.center(30)
  puts "\nAvailable squares: " + brd[:empty_squares].to_s
end
# rubocop enable Metrics/AbcSize

def new_board
  {
    empty_squares: [1, 2, 3, 4, 5, 6, 7, 8, 9],
    player_moves: [],
    computer_moves: []
  }
end

def player_turn(brd)
  loop do
    prompt "On which square will you put your '#{PLAYER_MARK}'?"
    move = gets.chomp.to_i
    if valid_move?(move, brd[:empty_squares])
      brd[:player_moves] << move
      brd[:empty_squares].delete(move)
      break
    else
      prompt "That choice is not valid. Please try again!"
    end
  end
end

def computer_turn(brd)
  brd[:computer_moves] << brd[:empty_squares].sample
  brd[:empty_squares].delete(brd[:computer_moves].last)
end

loop do
  board = new_board
  display_board(board)

  loop do
    player_turn(board)
    display_board(board)
    break if tie?(board) || winner?(board[:player_moves])

    computer_turn(board)
    display_board(board)
    break if tie?(board) || winner?(board[:computer_moves])
  end

  outcome = if winner?(board[:player_moves])
              "Nice work, you win!"
            elsif winner?(board[:computer_moves])
              "Looks like the computer won!"
            else
              "Tie game - nobody won"
            end
  prompt "#{outcome} End round..."

  answer = ''
  loop do
    prompt "Would you like to play again? [Y]es/[N]o"
    answer = gets.chomp
    break unless play_again?(answer) < 0
    prompt "#{answer} is an invalid response"
  end
  break unless play_again?(answer) == 1
end

prompt "Thanks for playing!  See you next time :)"
