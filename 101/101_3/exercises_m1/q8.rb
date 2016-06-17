def titleize(phrase)
  entitled = []
  phrase.split(" ").each do |word|
    entitled << word.capitalize
  end
  entitled.join(" ")
end

p titleize "Howdee doo dee"