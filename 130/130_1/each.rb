def each(array)
  counter = 0
  loop do 
    break if counter == array.count
    yield(array[counter])
    counter += 1
  end
  array
end

each([1, 2, 3, 4, 5]) do |num|
  puts num
end