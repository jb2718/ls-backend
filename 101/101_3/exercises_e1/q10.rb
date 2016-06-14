flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
indices = []
flintstones.each_index { |idx| indices << idx }
flintstones_hash_arr = flintstones.zip(indices)

p Hash[flintstones_hash_arr]