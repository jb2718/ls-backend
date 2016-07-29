def aeiou_be_gone(phrase)
  vowels = ['a','e','i','o','u','A','E','I','O','U']
  final = []
  words = phrase.split
  words.each do |word|
    no_vowels = ''
    word.each_char do |char|
      no_vowels << char unless vowels.include?(char)
    end
    if no_vowels.length > 0
      final << no_vowels
    end
  end
  final.join(' ')
end

my_phrase = "I can't stand the rain - against my window"

p aeiou_be_gone(my_phrase)