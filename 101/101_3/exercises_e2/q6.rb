ages = {"Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
smallest = ages["Herman"]
smallest_pair = {}
ages.each do |key,val|
  if val < smallest
    smallest = val
    smallest_pair.clear
    smallest_pair[key] = val
  end
end

p smallest_pair # This returns the smallest pair

# To only get the smallest value
p ages.values.min