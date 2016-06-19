def play_again?(response)
  if response.downcase == 'y' || response.downcase == 'yes'
    return 1
  elsif response.downcase == 'n' || response.downcase == 'no'
    return 0
  else
    return -1
  end   
end

def prompt(message)
  puts "=> #{message}"
end
puts "Welcome to Tic-Tac-Toe!"

play_again = 'no'
player_moves = []
computer_moves = []
loop do
  prompt "Here's a new board"

  prompt "Please choose your move"

  prompt "Here's the updated board"

  prompt "Computer chose..."

  prompt "Here's the updated board"
  

  loop do
    prompt "Would you like to play again? [Y]es/[N]o"
    play_again = gets.chomp
    break unless play_again?(play_again) < 0
    prompt "#{play_again} is an invalid response"
  end
  break unless play_again?(play_again) == 1
end

prompt "Thanks for playing!  See you next time :)"