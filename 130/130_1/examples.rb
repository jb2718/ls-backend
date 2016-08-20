def say(words)
  yield if block_given?
  puts "> " + words
end

say("hi there") do
  system 'clear'
end