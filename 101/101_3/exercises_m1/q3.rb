# It will produce an error because 40 + 2 is not
# a string and therefore cannot be concatenated
# with the preceding string


# Fix 1
puts "the value of 40 + 2 is " + (40 + 2).to_s

# Fix 2
puts "the value of 40 + 2 is #{40 + 2}"