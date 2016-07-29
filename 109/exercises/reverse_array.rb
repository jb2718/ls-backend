def reverse(arr)
  reversed = Array.new(arr.count(arr))
  index = arr.count(arr) - 1
  arr.each_char do |char|
    reversed[index] = char
    index -= 1
  end
  reversed.join()
end

phrase = "This is part 4 of our live session series on “Beginning Ruby”."
p reverse(phrase)