def is_prime?(num)
  (2..(num-1)).each do |factor|
    return false if num % factor == 0
  end 
  true
end
def inner_primes(start, final)
  primes = []
  primes = (start..final).to_a.select{ |num| is_prime?(num)}
end

p inner_primes(3,19) # => 3, 5, 7, 11, 13, 17, 19