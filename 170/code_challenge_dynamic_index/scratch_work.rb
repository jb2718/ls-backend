files = []

Dir["public/*"].each do |string|
    string.gsub!('public/', '')
    files << string.split('.').first
end

p files
p files.sort 
p files.sort { |x,y| y <=> x }