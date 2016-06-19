# I would refactor it by 1st changing the name of the method
# to reflect the intended result
# then I would make sure that both string and array do the
# same kind of thing...either they both modify the orig 
# param or they both leave the original unchanged

# Since I'm opting to modify the original, I will
# also add a bang to my method name

def add_word!(a_string_param, an_array_param)
  a_string_param << " rutabaga"
  an_array_param << "rutabaga"
end

my_string = "pumpkins"
my_array = ["pumpkins"]
add_word!(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"