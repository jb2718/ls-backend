def times(num)
  counter = 0
  loop do 
    break if counter == num
    yield(counter)
    counter += 1
  end
  num
end

times(5) do |num|
  puts num
end