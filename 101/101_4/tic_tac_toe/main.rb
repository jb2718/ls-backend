require 'pry'

PLAYER_MARK = 'X'.freeze
COMPUTER_MARK = 'O'.freeze
EMPTY_SQUARE_MARK = '*'.freeze
WHO_GOES_FIRST = 'choice' # 'player', 'computer', or 'choice'
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

def winner?(player, brd)
  if player == 'computer'
    moves = brd[:computer_moves]
  else
    moves = brd[:player_moves]
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
    combo_compare = moves.collect do |mark|
      combo.include?(mark)
    end
    puts combo_compare
    if combo_compare.count(true) == 2
      combo.each do |mark|
        return mark unless moves.include?(mark)
      end
    end
  end
  nil
end

def find_who_goes_first
  if WHO_GOES_FIRST.downcase == 'choice'
      loop do
        prompt "Choose who goes first. [P]layer or [C]omputer?"
        choice = gets.chomp
        if choice.downcase == 'p' || choice.downcase == 'player'
          return 'player'
        elsif choice.downcase == 'c' || choice.downcase == 'computer'
          return 'computer' 
        else
          prompt "That choice is not valid. Please try again!"
        end
      end
  elsif WHO_GOES_FIRST.downcase == 'computer'
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

  outcome = if winner?('player',board)
              board[:player_score] += 1
              "Nice work, you win!"
            elsif winner?('computer', board)
              board[:computer_score] += 1
              "Looks like the computer won!"
            else
              "Tie game - nobody won."
            end
  prompt outcome.to_s
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
