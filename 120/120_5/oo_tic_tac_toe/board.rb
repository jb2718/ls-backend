require './brain.rb'

class Square
  attr_accessor :mark, :position
  def initialize(idx)
    @mark = ' '
    @position = idx + 1 # represents 1 - 9 numbering of board
  end

  def marked?
    !@mark.nil? && @mark != ' '
  end
end

class Board
  attr_accessor :squares, :brain
  def initialize
    @squares = generate_squares
    @brain = Brain.new
  end

  def full?
    squares.each do |square|
      return false unless square.marked?
    end
    true
  end

  def clear
    squares.each do |square|
      square.mark = ' '
    end
  end

  def generate_squares
    arr = []
    9.times do |idx|
      arr << Square.new(idx)
    end
    arr
  end

  def []=(position, mark)
    squares[(position - 1)].mark = mark
  end

  def draw_section(unit, padding)
    str = ''
    str += "|" if unit.include?('|')
    3.times do |_|
      str += unit
    end
    width = str.size
    str.rjust(padding + width)
  end

  def vertical_with_mark(mark)
    "  #{mark}  |"
  end

  def draw_section_with_mark(first, second, third, padding)
    str = ''
    str += "|"
    str += vertical_with_mark(first)
    str += vertical_with_mark(second)
    str += vertical_with_mark(third)
    width = str.size
    str.rjust(padding + width)
  end

  # rubocop:disable Metrics/AbcSize
  def draw(padding=0)
    horizontal = " -----"
    vertical_no_mark = "     |"
    graphic_board = []

    graphic_board << draw_section(horizontal, padding)
    3.times do |idx|
      graphic_board << draw_section(vertical_no_mark, padding)
      graphic_board << draw_section_with_mark(squares[idx * 3].mark,
                                              squares[idx * 3 + 1].mark,
                                              squares[idx * 3 + 2].mark,
                                              padding)
      graphic_board << draw_section(horizontal, padding)
    end

    puts "\n\n"
    puts graphic_board.join("\n")
    puts "\n\n"
  end
  # rubocop:enable Metrics/AbcSize

  def open_moves
    moves = []
    arr = squares.select do |square|
      !square.marked?
    end
    arr.each do |square|
      moves << square.position
    end
    moves
  end

  def all_moves_of_type(mark)
    moves = []
    arr = squares.select do |square|
      square.mark == mark
    end
    arr.each do |square|
      moves << square.position
    end
    moves
  end

  def won?(mark)
    list_of_moves = []
    temp = squares.select { |square| square.mark == mark }
    return false if temp.count < 3
    temp.each { |square| list_of_moves << square.position }
    winning_moves = brain.find_wins(list_of_moves)
    winning_moves.count > 0
  end
end
