require 'pry'
# Write a method that will return all palindromes within a string
def is_palindrome?(word)
  letters = word.split('')
  center_idx = (word.length)/2 - 1
  start_half = letters[0..center_idx] 
  last_half = ''
  if word.length.even?
       last_half = letters[(center_idx+1)..-1]
  else
      last_half = letters[(center_idx+2)..-1]
  end
  start_half.length.times do
      return false unless start_half.shift == last_half.pop   
  end
  true
end

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

def palindromes(word)
  substrings(word).select {|word| is_palindrome?(word)}
end

def longest_palindrome(palindromes)
  longest_item = ''
  palindromes.each do |item|
    longest_item = item if item.length > longest_item.length
  end
  longest_item
end

p palindromes("ppop") #=> ['pp','pop']
p longest_palindrome(palindromes("ppop")) #=> ['pop']