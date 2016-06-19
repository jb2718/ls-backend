=begin
A) the output after the function is run will not be different than
it was before the function was run

B) the output after the function is run will not be different than
it was before the function was run

C) output:
one is: two
two is: three
three is: one

=end

def mess_with_vars(one, two, three)
  one.gsub!("one","two")
  two.gsub!("two","three")
  three.gsub!("three","one")
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}"
puts "two is: #{two}"
puts "three is: #{three}"