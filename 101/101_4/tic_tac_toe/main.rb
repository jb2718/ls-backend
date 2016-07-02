require 'pry'

PLAYER_MARK = 'X'.freeze
COMPUTER_MARK = 'O'.freeze
EMPTY_SQUARE_MARK = '*'.freeze
WHO_GOES_FIRST = 'choice'.freeze # 'player', 'computer', or 'choice'
WINNING_COMBOS = [
  [1, 2, 3], [4, 5, 6], [7, 8, 9],
  [1, 4, 7], [2, 5, 8], [3, 6, 9],
  [1, 5, 9], [3, 5, 7]
].freeze

def play_again?
  answer = ''
  loop do
    prompt "Would you like to play again? [Y]es/[N]o"
    answer = gets.chomp
    case answer.downcase
    when 'y', 'yes'
      return true
    when 'n', 'no'
      return false
    else
      prompt "#{answer} is an invalid response."
    end
  end
end

def valid_move?(move, board)
  board.include?(move)
end

def prompt(message)
  puts "=> #{message}"
end

def winner?(player, brd)
  moves = if player == 'computer'
            brd[:computer_moves]
          else
            brd[:player_moves]
          end
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

def joinor(list, token=',', word='or')
  tail = list.last
  if list.count > 2
    head = list[0..-2]
    head.join(token) + "#{token}#{word} #{tail}"
  elsif list.count == 2
    list.first.to_s + " #{word} #{tail}"
  else
    tail.to_s
  end
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
  puts "\nAvailable squares: " + joinor(brd[:empty_squares], ', ', 'and')
end
# rubocop enable Metrics/AbcSize

def new_board
  {
    empty_squares: [1, 2, 3, 4, 5, 6, 7, 8, 9],
    player_moves: [],
    player_score: 0,
    computer_moves: [],
    computer_score: 0
  }
end

def reset_board(brd)
  brd[:empty_squares] = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  brd[:player_moves] = []
  brd[:computer_moves] = []
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
  ai_offense = computer_ai(brd[:computer_moves])
  ai_defense = computer_ai(brd[:player_moves])
  if ai_offense && brd[:empty_squares].include?(ai_offense)
    brd[:computer_moves] << ai_offense
    brd[:empty_squares].delete(ai_offense)
  elsif ai_defense && brd[:empty_squares].include?(ai_defense)
    brd[:computer_moves] << ai_defense
    brd[:empty_squares].delete(ai_defense)
  elsif brd[:empty_squares].include?(5)
    brd[:computer_moves] << 5
    brd[:empty_squares].delete(5)
  else
    brd[:computer_moves] << brd[:empty_squares].sample
    brd[:empty_squares].delete(brd[:computer_moves].last)
  end
end

def computer_ai(moves)
  WINNING_COMBOS.each do |combo|
    combo_compare = moves.select do |mark|
      combo.include?(mark)
    end
    next unless combo_compare.count == 2
    combo.each do |mark|
      return mark unless moves.include?(mark)
    end
  end
  nil
end

def choose_first_player
  loop do
    prompt "Choose who goes first. [P]layer or [C]omputer?"
    choice = gets.chomp
    choice.downcase!
    if choice == 'p' || choice == 'player'
      return 'player'
    elsif choice == 'c' || choice == 'computer'
      return 'computer'
    else
      prompt "That choice is not valid. Please try again!"
    end
  end
end

def find_who_goes_first
  case WHO_GOES_FIRST.downcase
  when 'choice'
    choose_first_player
  when 'computer'
    'computer'
  else
    'player'
  end
end

def alternate_player(player)
  if player == 'computer'
    'player'
  else
    'computer'
  end
end

def play_game(curr_player, brd)
  if curr_player == 'player'
    player_turn(brd)
  else
    computer_turn(brd)
  end
  display_board(brd)
end

board = new_board
loop do
  current_player = find_who_goes_first
  reset_board(board)
  display_board(board)

  loop do
    play_game(current_player, board)
    break if tie?(board) || winner?(current_player, board)
    current_player = alternate_player(current_player)
  end

  winner = if winner?('player', board)
             :player
           elsif winner?('computer', board)
             :computer
           end

  case winner
  when :player
    board[:player_score] += 1
  when :computer
    board[:computer_score] += 1
  end

  outcome = case winner
            when :player
              "Nice work, you win!"
            when :computer
              "Looks like the computer won!"
            else
              "Tie game - nobody won."
            end

  prompt outcome
  prompt "Player Points: #{board[:player_score]}"
  prompt "Computer Points: #{board[:computer_score]}"
  prompt "End of Round..."

  if board[:player_score] == 5
    prompt "You scored 5 points first and won the whole game!"
    board = new_board
  elsif board[:computer_score] == 5
    prompt "The computer scored 5 points first and won the whole game!"
    board = new_board
  end

  break unless play_again?
end

prompt "Thanks for playing!  See you next time :)"
