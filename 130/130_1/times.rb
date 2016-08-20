require 'pry'

def repeat_me_times(num)
  count = 0
  loop do
    break if count >= (num)
    yield(count) if block_given?
    count += 1
  end
  num
end

repeat_me_times(5) do |num|
  puts num
end