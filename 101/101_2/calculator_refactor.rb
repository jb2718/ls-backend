def prompt(msg)
  puts "=> #{msg}"
end

def valid_number?(num)
  if num.start_with('0')
    true
  else
    num.to_i != 0
  end
end

def operator_to_msg(op)
  msg = case op
        when '1'
          "Adding"
        when '2'
          "Subtracting"
        when '3'
          "Multiplying"
        when '4'
          "Dividing"
        end
  msg
end

prompt("Welcome to Calculator!")
name = ''
loop do
  prompt("What's your name? ")
  name = gets.chomp
  if name.empty? || name.nil?
    prompt("Please use a valid name")
  else
    break
  end
end

prompt("Hi #{name}")

loop do # main loop
  first_num = ''
  loop do
    prompt("Please enter the first integer: ")
    first_num = gets.chomp

    if valid_number?(first_num)
      break
    else
      prompt("Invalid number...please try again")
    end
  end

  puts

  second_num = ''
  loop do
    prompt("Please enter the second integer: ")
    second_num = gets.chomp

    if valid_number?(second_num)
      break
    else
      prompt("Invalid number...please try again")
    end
  end

  puts

  operator_prompt = <<-MSG
  Which operation would you like to perform? :
    1) addition
    2) subtraction
    3) multiplication
    4) division
MSG
  prompt(operator_prompt)

  operation = ''
  loop do
    operation = gets.chomp
    if %w(1 2 3 4).include?(operation)
      break
    else
      prompt("Please choose 1, 2, 3 or 4")
    end
  end

  prompt("#{operator_to_msg(operation)} the two numbers...")

  result =  case operation
            when '1'
              first_num.to_i + second_num.to_i
            when '2'
              first_num.to_i - second_num.to_i
            when '3'
              first_num.to_i * second_num.to_i
            when '4'
              first_num.to_f / second_num.to_f
            else
              prompt('Invalid entry')
            end

  prompt("The result is #{result}")

  prompt("Would you like to do another calculation? [Y]es or [N]o")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt("See ya later!")
