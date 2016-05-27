# You'll need three pieces of information:

# the loan amount
# the Annual Percentage Rate (APR)
# the loan duration
# From the above, you'll need to calculate the following two things:

# monthly interest rate
# loan duration in months

# P = L[c(1 + c)n]/[(1 + c)n - 1]



#===========PseudoCode===========
# Display welcome msg
# Ask user for loan amount
# Ask user for APR
# Ask user for loan duration
# Calculate monthly payment
# # ====================================

puts "===================================="
puts "      Mortgage Caculator App"
puts "===================================="

puts "Welcome to the Mortgage Caculator!"

puts "How much money do you need to borrow to purchase the house?"
loan = gets.chomp.to_f

puts "How much will you be charged each year to borrow this money?"
puts "(Please enter the APR as a number between 0 and 100): "
apr = gets.chomp
monthly_int = apr.to_f/(100 *12)

puts "How many years do you need to pay the loan back?"
term_years = gets.chomp.to_f
term_months = term_years * 12


# P = L[c(1 + c)n]/[(1 + c)n - 1]
monthy_payment_ratio_num = monthly_int * (1 + monthly_int)**term_months 
monthy_payment_ratio_denom = (1 + monthly_int)**term_months - 1
monthly_payment = loan * ( monthy_payment_ratio_num / monthy_payment_ratio_denom)

response = <<-RESP
In order to buy a property that costs $#{loan}, 
you will need to pay #{monthly_payment} per month
for #{term_months} months (that's #{term_years} years)

RESP
puts response