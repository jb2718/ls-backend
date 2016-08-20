def select(list)
  count = 0
  val = false
  selected_items = []
  loop do
    break if count >= list.length
    val = yield(list[count]) if block_given?
    selected_items << list[count] if val
    count += 1
  end
  selected_items
end

array = [1, 2, 3, 4, 5]

p select(array) { |num| num.odd? }      # => [1, 3, 5]
p array.select { |num| puts num }       # => [], because "puts num" returns nil and evaluates to false
p array.select { |num| num + 1 }        # => [1, 2, 3, 4, 5], because "num + 1" evaluates to true