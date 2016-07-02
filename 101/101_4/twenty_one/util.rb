def prompt(message)
  puts "=> #{message}\n"
end

def play_again?
  answer = ''
  loop do
    puts "---------------------------------------------------"
    prompt "Would you like to play again? [Y]es/[N]o"
    answer = gets.chomp

    case answer.downcase
    when 'y', 'yes'
      return true
    when 'n', 'no'
      return false
    else
      prompt "#{answer} is an invalid response"
    end
  end
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
