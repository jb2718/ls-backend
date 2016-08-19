class History
  attr_reader :table

  def initialize
    @table = []
  end

  def to_s
    puts "================\n" + "History of Moves\n" + "================\n"
    table.each_with_index do |data, idx|
      puts "Round: #{idx + 1}"
      puts "User Move: #{data[:user]}"
      puts "Computer Move: #{data[:computer]}"
    end
  end

  def insert(record)
    @table << record
  end

  def find_by_round(round)
    @table[round]
  end

  def find_by(attribute, value)
    @table.map do |record|
      record[attribute] == value
    end
  end
end

class AI
  
  def initialize
    # config settings
  end

  def enemy_tendency(move)
    # If player "tends" to pick <move>
    # - need to define my window of tendency and the number of tendency
    # - need a specific move to track
    #  - formula is something like if the average for a move over the whole history is above a certain threshhold
    #  - calculate some kind of probabilty and return that
  end

  def enemy_in_a_row(player, move, times)
      # If opponent has picked <move> <number> of times in a row in most recent history
      # - need to determine what 'times in a row' is
      # - calculate some kind of factor/probability that he will do it again & return that

      # if enemy history includes move x y times in a row
      #   pick something that beats x
      # else
      #   don't use this to determine your move
      # end
  end

  def my_weakness(move)
    # How often do I  get beaten by picking <move>
    # - return a percentage
    # - of times I have picked <move>
    # - of those times, number of times I've been beaten
    # - I get beaten x percent of the time I pick y:  #times beaten / # times picked (out of total hx)
    # - this function returns a percentage...it's up to personality to say if percentage is high enough
  end

  # part of the personality of different cpu players will be to define the percentages and 
  # threshholds - so each personality will get its own AI object and set the config settings
end