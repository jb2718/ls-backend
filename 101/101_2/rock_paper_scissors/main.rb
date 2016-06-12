# main.rb rock paper scissors main file
VALID_CHOICES = %w(rock paper scissors)
$player_points = 0
$computer_points = 0

def test_method
  prompt('test method')
end

# test_method - cannot invoke this method bf defining prompt method

def prompt(message)
  puts "=> #{message}"
end

def won?(first, second)
  win = [%w(rock scissors), %w(paper rock), %w(scissors paper)]
  check = []
  check << first << second
  return true if win.include?(check)

  false
end

def display_points
  prompt "Your points: #{$player_points}"
  prompt "Computer points: #{$computer_points}"
end

def display_results(player, computer)
  if won?(player, computer)
    prompt "You won this round!"
  elsif won?(computer, player)
    prompt "Computer won this round!"
  else
    prompt "It's a tie!"
  end
  display_points
end

def tally_points(player, computer)
  if won?(player, computer)
    $player_points += 1
  elsif won?(computer, player)
    $computer_points += 1
  end
end

def reset_points
  $player_points = 0
  $computer_points = 0
end

loop do
  choice = ''

  loop do
    prompt "Choose one: #{VALID_CHOICES.join(', ')}"
    choice = gets.chomp

    if VALID_CHOICES.include?(choice)
      break
    else
      prompt "That is not a valid choice."
    end
  end

  computer_choice = %w(rock paper scissors).sample

  prompt "You chose: #{choice}; Computer chose #{computer_choice}"

  tally_points(choice, computer_choice)
  display_results(choice, computer_choice)

  if $player_points == 5
    prompt "You scored 5 points first and won the whole game!"
    reset_points
  elsif $computer_points == 5
    prompt "The computer scored 5 points first and won the whole game!"
    reset_points
  end

  prompt "Would you like to play again? (Yes or No)"
  play_again = gets.chomp
  break unless play_again.downcase.start_with?('y')
end

prompt "Thank you for playing.  Goodbye!"
