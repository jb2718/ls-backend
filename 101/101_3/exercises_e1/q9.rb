flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }

p flintstones

flintstones.select! {|key, value| key == 'Barney'}

p flintstones.to_a.flatten!