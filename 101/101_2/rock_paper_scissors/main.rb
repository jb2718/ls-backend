# main.rb rock paper scissors main file
VALID_CHOICES = %w(rock paper scissors lizard spock)
scorecard = [0, 0] # index0 = player points, index1 = computer points

def test_method
  prompt('test method')
end

# test_method - cannot invoke this method bf defining prompt method

def prompt(message)
  puts "=> #{message}"
end

def won?(first, second)
  win = [%w(rock scissors), %w(paper rock), %w(scissors paper)]
  win << %w(rock lizard) << %w(paper spock) << %w(scissors lizard)
  win << %w(spock scissors) << %w(spock rock) << %w(lizard spock)
  win << %w(lizard paper)
  check = []
  check << first << second
  return true if win.include?(check)

  false
end

def display_results(player, computer, scorecard)
  if won?(player, computer)
    prompt "You won this round!"
  elsif won?(computer, player)
    prompt "Computer won this round!"
  else
    prompt "It's a tie!"
  end
  prompt "Your points: #{scorecard[0]}"
  prompt "Computer points: #{scorecard[1]}"
end

def update_points(player, computer, scorecard)
  if won?(player, computer)
    scorecard[0] += 1
  elsif won?(computer, player)
    scorecard[1] += 1
  end
end

def reset_points(scorecard)
  scorecard.fill(0)
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

  computer_choice = %w(rock paper scissors lizard spock).sample

  prompt "You chose: #{choice}; Computer chose #{computer_choice}"
  update_points(choice, computer_choice, scorecard)
  display_results(choice, computer_choice, scorecard)

  if scorecard[0] == 5
    prompt "You scored 5 points first and won the whole game!"
    reset_points(scorecard)
  elsif scorecard[1] == 5
    prompt "The computer scored 5 points first and won the whole game!"
    reset_points(scorecard)
  end

  prompt "Would you like to play again? (Yes or No)"
  play_again = gets.chomp
  break unless play_again.downcase.start_with?('y')
end

prompt "Thank you for playing.  Goodbye!"
