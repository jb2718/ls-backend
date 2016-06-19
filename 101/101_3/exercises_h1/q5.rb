#possible refactoring
def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  unless dot_separated_words.size != 4
    dot_separated_words.each do |word|
      return false if !is_a_number?(word)
    end
    return true
  end
  false
end