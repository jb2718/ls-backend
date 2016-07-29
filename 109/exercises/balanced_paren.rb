def balanced?(string)
  list = []
  string.each_char do |char|
    if char == '('
      list << char
    end
    if char == ')' && list.last == '('
      list.pop
    elsif char == ')'
      list << char
    end
  end
  return false unless list.empty?
  true
end

test = '()())('
test2 = '(())((())())'

p balanced?(test)
p balanced?(test2)