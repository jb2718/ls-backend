def say(words)
  yield if block_given?
  puts "> " + words
end

say("hi there") do
  system 'clear'
end

def test(&block)
  puts "What's &block? #{block}"
end

test { |num| puts num }