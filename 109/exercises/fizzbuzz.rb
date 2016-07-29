require 'pry'
"""
Write a method that takes two arguments:
 the first is the starting number, and the second
  is the ending number. Print out all numbers
   between the two numbers, except if a number
    is divisible by 3, print \"Fizz\", if a number 
    is divisible by 5, print \"Buzz\", and
     finally if a number is divisible by 3 and 5
      print \"FizzBuzz\".
"""

def fizzbuzz(start, finish)
  output = []
  (start..finish).to_a.each do |num|
    if num % 3 == 0 && num % 5 == 0
      output << "FizzBuzz"
    elsif num % 3 == 0
      output << "Fizz"
    elsif num % 5 == 0
      output << "Buzz"
    else
      output << num
    end
  end
  output
end

p fizzbuzz(1,15)