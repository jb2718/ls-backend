def play_again?(response)
  if response.downcase == 'y' || response.downcase == 'yes'
    return 1
  elsif response.downcase == 'n' || response.downcase == 'no'
    return 0
  else
    return -1
  end   
end

def valid_move?(move, board)
  board.include?(move)
end

def prompt(message)
  puts "=> #{message}"
end

def winner?(moves, board)
  winning_combos = [
    [1,2,3], [4,5,6], [7,8,9],
    [1,4,7], [2,5,8], [3,6,9],
    [1,5,9], [3,5,7]
  ]
  winning_combos.each do |combo|
    three_in_a_row = 0
    combo.each do |number|
      break unless moves.include?(number)
      three_in_a_row += 1
    end
    return true if three_in_a_row == 3
  end
  false
end

def tie?(board)
  board.empty?
end

def display_board(x_list, o_list)
  current_board = ['1','2','3','4','5','6','7','8','9']
  x_list.each{ |square| current_board[square - 1] = 'X' }
  o_list.each{ |square| current_board[square - 1] = 'O' }
  row1 = current_board[0].ljust(6) + current_board[1].ljust(6) + current_board[2]
  row2 = current_board[3].ljust(6) + current_board[4].ljust(6) + current_board[5]
  row3 = current_board[6].ljust(6) + current_board[7].ljust(6) + current_board[8]

  puts row1.center(40)
  puts row2.center(40)
  puts row3.center(40)
end

puts "Welcome to Tic-Tac-Toe!"

play_again = 'no'

loop do
  board_options = [1,2,3,4,5,6,7,8,9]
  player_moves = []
  computer_moves = []
  prompt "Here's a new board"
  display_board(player_moves, computer_moves)
  p board_options


  loop do
    prompt "You are X's." 
    loop do
      prompt "Choose which square to put your 'X'"
      move = gets.chomp.to_i
      if valid_move?(move,board_options)
        player_moves << move
        board_options.delete(move)
        break
      else
        prompt "That choice is not valid. Please try again!"
      end
    end

    prompt "Here's the updated board"
    display_board(player_moves, computer_moves)
    p board_options
    break if tie?(board_options) || winner?(player_moves, board_options)

    prompt "Computer is O's."  
    computer_moves << board_options.sample
    board_options.delete(computer_moves.last)
    prompt "Computer chose square #{computer_moves.last}"

    prompt "Here's the updated board"
    display_board(player_moves, computer_moves)
    p board_options
    break if tie?(board_options) || winner?(computer_moves, board_options)
  end
  
  outcome = case 
            when winner?(player_moves, board_options)
              "Nice work, you win!"
            when winner?(computer_moves, board_options)
              "Looks like the computer won!"
            else
              "Tie game - nobody won"
            end
  prompt "#{outcome} End round..."

  loop do
    prompt "Would you like to play again? [Y]es/[N]o"
    play_again = gets.chomp
    break unless play_again?(play_again) < 0
    prompt "#{play_again} is an invalid response"
  end
  break unless play_again?(play_again) == 1
end

prompt "Thanks for playing!  See you next time :)"