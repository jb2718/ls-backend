require 'yaml'
LANGUAGE ='es'
MESSAGES = YAML.load_file('messages.yml')

def messages(message, lang='en')
  MESSAGES[lang][message]
end

def prompt(msg)
  msg = messages(msg, LANGUAGE)
  puts "=> #{msg}"
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
puts MESSAGES[LANGUAGE]['title']
puts "===================================="

prompt 'welcome'

loop do # main loop
  loan = ""
  loop do
    prompt 'get_loan_amt'
    prompt 'get_loan_amt_note'
    loan = gets.chomp

    if valid_dollar_amt?(loan)
      break
    else
      prompt 'invalid_input'
      prompt 'invalid_input_dollars'
    end
  end

  apr = ""
  loop do
    prompt 'get_apr'
    prompt 'get_apr_note'
    apr = gets.chomp
    if valid_apr?(apr)
      break
    else
      prompt 'invalid_input'
    end
  end

  term_years = ""
  loop do
    prompt 'get_years'
    term_years = gets.chomp
    if valid_years?(term_years)
      break
    else
      prompt 'invalid_input'
      prompt 'invalid_input_years'
    end
  end

  prompt 'calculating'

  # P = L[c(1 + c)n]/[(1 + c)n - 1]
  monthly_int = apr.to_f / (100 * 12)
  term_months = term_years.to_i * 12

  monthy_payment_ratio_num = monthly_int * (1 + monthly_int)**term_months
  monthy_payment_ratio_denom = (1 + monthly_int)**term_months - 1
  charge_factor = (monthy_payment_ratio_num / monthy_payment_ratio_denom)
  monthly_payment = loan.to_f * charge_factor

  response =  MESSAGES[LANGUAGE]['response']['line1'] + "$#{format('%#.2f', monthly_payment.round(2))} \n" +
              MESSAGES[LANGUAGE]['response']['line2'] + "$#{loan}\n" + 
              MESSAGES[LANGUAGE]['response']['line3'] + "#{term_years} " + MESSAGES[LANGUAGE]['response']['line4']
  puts response

  prompt 'another_calculation'
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end # end main loop

prompt 'good_bye'
