Kernel.puts('Please enter the first number: ')
first_num = Kernel.gets().chomp()
Kernel.puts('The first number is: ' + first_num.to_f.to_s)

puts

Kernel.puts('Please enter the second number: ')
second_num = Kernel.gets().chomp()
Kernel.puts('The second number is: ' + second_num.to_f.to_s)

puts

Kernel.puts('Which operation would you like to perform? 1) addition 2) subtraction 3) multiplication 4) division ?: ')
operation = Kernel.gets().chomp()

case operation
when '1'
  sum = first_num.to_f + second_num.to_f
  Kernel.puts(first_num.to_f.to_s + ' + ' + second_num.to_f.to_s + ' = ' + sum.to_s)
when '2'
  difference = first_num.to_f - second_num.to_f
  Kernel.puts(first_num.to_f.to_s + ' - ' + second_num.to_f.to_s + ' = ' + difference.to_s)
when '3'
  product = first_num.to_f * second_num.to_f
  Kernel.puts(first_num.to_f.to_s + ' * ' + second_num.to_f.to_s + ' = ' + product.to_s)
when '4'
  quotient = first_num.to_f / second_num.to_f
  Kernel.puts(first_num.to_f.to_s + ' / ' + second_num.to_f.to_s + ' = ' + quotient.to_s)
else
  puts 'Invalid entry'  
end