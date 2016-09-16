#Object-Oriented Twenty-One Card Game
This is an object oriented version of a card game similar to the casino favorite Twenty-One.  It has two players and the dealer is always the computer player.

##Settings
Inside the Game class (which can be found in "main.rb"), there are three constants you can set according to your own whims: MAX_SCORE, DEALER_MAX and WINNING_VALUE

MAX_SCORE is the number of points it takes to win an entire game.  Each game is comprised of several rounds of twenty-one.  The first player to reach the MAX_SCORE wins the game and the scores are reset on the next round.  This setting should be set to an integer greater than or equal to 1.

WINNING_VALUE represents the number of points it takes to win a round.  Traditionally, this number is 21, however you can change it to any integer you would like.  

* **Caution!** - Please make sure to set this number to an interger that is greater than DEALER_MAX

DEALER_MAX represents the number of points the computer player will try to reach before "choosing" to stay.  

* **Caution!** - Please make sure to set this number to an interger that is less than WINNING_VALUE


##Instructions

* Enter `$ ruby main.rb` from the root folder

* Once the game starts, you will be prompted to enter a name for the human user

* Once the game starts, you should see a board with the players' first two cards and scores.  One of the dealer's cards as well as the dealer's score will initially be masked.

* The human user goes first.  She is prompted to hit or stay.

* Once the round ends, you will be asked if you would like to play again or not.  Enter "yes" (or 'y') to continue playing or "no" (or 'n') to end the program


##Development
This game was built using Ruby 2.3.0p0