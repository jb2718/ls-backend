class History
  attr_reader :table

  def initialize
    @table = []
  end

  def to_s
    message = ''
    message += "================\n"
    message += "History of Moves\n"
    message += "================\n"

    table.each_with_index do |data, idx|
      message += "Round: #{idx + 1}\n"
      message += "User Move: #{data[:user]}\n"
      message += "Computer Move: #{data[:computer]}\n"
    end
    message
  end

  def insert(record)
    @table << record
  end

  def find_by_round(round)
    @table[round]
  end

  def find_by(attribute, value)
    @table.select do |record|
      record[attribute.to_sym] == value
    end
  end

  def length
    @table.length
  end
end
