# Write a method that will return a substring based on specific indices.
def substring(word, start, finish=nil)
  return word[start] if finish.nil?
  word[start..finish]
end
 
p substring("honey", 0, 2) # => "hon"
p substring("honey", 1, 2) # => "on"
p substring("honey", 3, 9) # => "ey"
p substring("honey", 2) # => "n"