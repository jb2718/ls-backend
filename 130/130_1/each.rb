def each(list)
  count = 0
  loop do
    break if count >= list.length
    yield(list[count]) if block_given?
    count += 1
  end
  list
end

each([1,2,3]) do |item|
  puts item
end

puts "-------------------------"

p each([1, 2, 3, 4, 5]) {|num| "do nothing"}.select{ |num| num.odd? } 