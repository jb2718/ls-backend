sentence =  "Humpty Dumpty sat on a wall."

puts sentence.split(/\W/).map {|word| word.reverse }.join(" ") + '.'