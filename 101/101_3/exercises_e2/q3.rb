ages = {"Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

ages.select! {|key, val| val < 100 }

p ages