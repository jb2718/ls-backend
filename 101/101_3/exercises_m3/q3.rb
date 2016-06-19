def tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param << "rutabaga"
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method(my_string, my_array)

# my_string = "pumpkins" - the '+=' operator is not a mutative operator
puts "My string looks like this now: #{my_string}"

# my_array = ["pumpkins", "rutabaga"]; the '<<' operator mutates
# the object it is called upon
puts "My array looks like this now: #{my_array}"