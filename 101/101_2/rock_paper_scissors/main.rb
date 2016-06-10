# main.rb rock paper scissors main file
VALID_CHOICES = ['rock', 'paper', 'scissors']
def prompt(message)
	puts "=> #{message}"
end

def display_results(player, computer)
	if (player == 'rock' && computer == 'scissors') ||
		(player == 'paper' && computer == 'rock') ||
		(player == 'scissors' && computer == 'paper')
		prompt "You won!"
	elsif (player == 'rock' && computer == 'paper') ||
		(player == 'paper' && computer == 'scissors') ||
		(player == 'scissors' && computer == 'rock')
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

	computer_choice = ['rock', 'paper', 'scissors'].sample

	prompt "You chose: #{choice}; Computer chose #{computer_choice}"
	
	display_results(choice, computer_choice)

	prompt "Would you like to play again? (Yes or No)"
	play_again = gets.chomp
	break unless play_again.downcase.start_with?('y')
end

prompt "Thank you for playing.  Goodbye!"