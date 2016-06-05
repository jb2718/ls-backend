def prompt(message)
  puts "=> #{message}"
end

def valid_dollar_amt?(number)
  regex = /\A(\d*\.{0,1}\d{0,2})\z/

  if !number.include?(",") || !regex.match(number).nil?
    true
  else
    false
  end
end

def valid_apr?(value)
  regex = /\A(\d{1,3}\.{0,1}\d*)\z/
  unless regex.match(value).nil?
    value = regex.match(value)[0].to_f
    if value >= 0 && value <= 100
      return true
    else
      return false
    end
  end
  false
end

def valid_years?(value)
  regex = /\A(\d{1,2})\z/
  unless regex.match(value).nil?
    value = regex.match(value)[0].to_i
    if value > 0 && value <= 40
      return true
    else
      return false
    end
  end
  false
end

puts "===================================="
puts "      Mortgage Caculator App"
puts "===================================="

prompt "Welcome to the Mortgage Caculator!"

loop do # main loop
  loan = ""
  loop do
    prompt "How much money do you need to borrow to purchase the house?"
    prompt "(Please do not enter commas ',''):"
    loan = gets.chomp

    if valid_dollar_amt?(loan)
      break
    else
      prompt "Invalid dollar amount."
      prompt "Make sure to have no more than 2 digits after the decimal."
      prompt "Please try again!"
    end
  end

  apr = ""
  loop do
    prompt "How much will you be charged each year to borrow this money?"
    prompt "(Please enter the APR as a number between 0 and 100): "
    apr = gets.chomp
    if valid_apr?(apr)
      break
    else
      prompt "That's not a valid input.  Please try again!"
    end
  end

  term_years = ""
  loop do
    prompt "How many years do you need to pay the loan back?"
    term_years = gets.chomp
    if valid_years?(term_years)
      break
    else
      prompt "That's not a valid input."
      prompt "Make sure to enter an integer between 1 and 40."
      prompt "Please try again!"
    end
  end

  prompt "Calculating monthly payment..."

  # P = L[c(1 + c)n]/[(1 + c)n - 1]
  monthly_int = apr.to_f / (100 * 12)
  term_months = term_years.to_i * 12

  monthy_payment_ratio_num = monthly_int * (1 + monthly_int)**term_months
  monthy_payment_ratio_denom = (1 + monthly_int)**term_months - 1
  charge_factor = (monthy_payment_ratio_num / monthy_payment_ratio_denom)
  monthly_payment = loan.to_f * charge_factor

  response = <<-RESP
  In order to buy a property that costs $#{loan},
  you will need to pay $#{format('%#.2f', monthly_payment.round(2))} per month
  for #{term_months} months (that's #{term_years} years)

  RESP
  prompt response

  prompt "Do you want to do another calculation? (Y to calculate again): "
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end # end main loop

prompt "Thanks for using Mortgage Calculator!  Goodbye!"
