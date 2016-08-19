class Game
  def play
    puts "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    # rules of play
  end

  def play
    puts "Starting bingo!"
  end
end

game1 = Bingo.new
game1.play