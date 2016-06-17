munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female" }
}

def add_age_group(hash)
  hash.each_value do |val|
    if (0..17).include?(val["age"])
      group = "kids"
    elsif (18..64).include?(val["age"])
      group = "adults"
    else
      group = "senior"
    end
   
    val["age_group"] = group
  end
end

p add_age_group(munsters)