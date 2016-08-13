class Player
  attr_accessor :name, :move, :score

  def initialize
    @score = Score.new
    set_name
  end

  def display_score
    coda = @score.value == 1 ? "point" : "points"
    puts "#{self.name} has #{@score} #{coda}."
  end
end

class Human < Player
  def set_name
    n = nil
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "That is not a valid entry.  Try again!"
    end
    @name = n
  end

  def choose
    choice = nil
    loop do
      puts "Choose one: rock, paper, scissors, lizard, or spock"
      choice = gets.chomp.downcase

      if Move::VALUES.include?(choice)
        @move = Move.new(choice)
        puts "#{@name} chose: #{@move}"
        break
      else
        puts "That is not a valid choice."
      end
    end
  end
end

class Computer < Player
  def set_name
    @name = ['Number 5', 'R2D2', 'Eve', 'Wall-E'].sample
  end

  def choose
    # @move = Move.new(Move::VALUES.sample)
    @move = Move.new('paper')
    puts "#{@name} chose: #{@move}"
  end
end