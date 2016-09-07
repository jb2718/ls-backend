def prompt(msg)
  puts "=> #{msg}"
end

def joinor(list, token=',', word='or')
  tail = list.last
  if list.count > 2
    head = list[0..-2]
    head.join(token) + "#{token}#{word} #{tail}"
  elsif list.count == 2
    list.first.to_s + " #{word} #{tail}"
  else
    tail.to_s
  end
end
