def factors(number)
  dividend = number
  divisors = []
  while dividend > 0 do
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
  end
  divisors
end

p factors(0)
p factors(4)
p factors(-3)

# The purpose of number % dividend == 0 is to make sure the
# dividend divides into the divisor evenly before saving it
# as a factor

# The second to last line is there to return the array of divisors
# back to whoever called this method