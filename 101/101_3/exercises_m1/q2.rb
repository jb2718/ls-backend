statement = "The Flintstones Rock"
letter_hash = {}
statement.scan(/./).each do |letter|
  if letter_hash.include?(letter)
    letter_hash[letter] += 1
  else
    letter_hash[letter] = 1
  end
end

p letter_hash