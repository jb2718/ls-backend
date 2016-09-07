class Brain
  WINNING_COMBOS = [
    [1, 2, 3], [4, 5, 6], [7, 8, 9],
    [1, 4, 7], [2, 5, 8], [3, 6, 9],
    [1, 5, 9], [3, 5, 7]
  ].freeze
  def initialize
  end

  def invert(list)
    (1..9).to_a.select { |num| !list.include?(num) }
  end

  def filter(num)
    WINNING_COMBOS.select do |combo|
      combo.include?(num)
    end
  end

  def find_wins(list)
    wins = Array.new(WINNING_COMBOS)
    not_marked = invert(list)
    temp = []
    loop do
      break if not_marked.empty? || wins.empty?
      temp = filter(not_marked.pop)
      if !temp.empty?
        temp.each { |combo| wins.delete(combo) }
      end
    end
    wins
  end

  def complete_two_in_row(moves)
    WINNING_COMBOS.each do |combo|
      combo_compare = moves.select do |mark|
        combo.include?(mark)
      end
      next unless combo_compare.count == 2
      combo.each do |mark|
        return mark unless moves.include?(mark)
      end
    end
    nil
  end
end
