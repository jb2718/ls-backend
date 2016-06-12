# main.rb rock paper scissors main file
VALID_CHOICES = %w(rock paper scissors)

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

def display_results(player, computer)
  if won?(player, computer)
    prompt "You won!"
  elsif won?(computer, player)
    prompt "Computer won!"
  else
    prompt "It's a tie!"
  end
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

  display_results(choice, computer_choice)

  prompt "Would you like to play again? (Yes or No)"
  play_again = gets.chomp
  break unless play_again.downcase.start_with?('y')
end

prompt "Thank you for playing.  Goodbye!"
