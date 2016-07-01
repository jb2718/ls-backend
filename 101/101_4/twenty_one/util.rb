def prompt(message)
  puts "=> #{message}\n"
end

# rubocop:disable Performance/Casecmp
def play_again?(response)
  if response.downcase == 'y' || response.downcase == 'yes'
    return 1
  elsif response.downcase == 'n' || response.downcase == 'no'
    return 0
  else
    return -1
  end
end
# rubocop:enable Performance/Casecmp

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
