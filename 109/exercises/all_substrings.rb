# Write a method that finds all substrings in a string.  No 1 letter words.
def substrings(word)
  start = (0..(word.length-1)).to_a
  finish = (0..(word.length-1)).to_a
  ranges = start.product(finish)
  substring_arr = []
  ranges.each do |range|
    next if range.first > range.last
    substring_arr << word[range.first..range.last]
  end
  trash = substring_arr.select {|str| str.length == 1}
  substring_arr.delete_if {|str| trash.include?(str)}
end

p substrings("band") # => ['ba', 'ban', 'band', 'an', 'and', 'nd']