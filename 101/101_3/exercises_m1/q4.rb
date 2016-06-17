numbers = [1,2,3,4]
numbers.each do |number|
  p number
  numbers.shift(1)
end

#This code will print: 
# 1
# 3

numbers = [1,2,3,4]
numbers.each do |number|
  p number
  numbers.pop(1)
end

#This code will print: 
# 1
# 2

#If you modify the array while you are iterating
# over it, there may be unexpected outcomes