advice = "Few things in life are as important as house training your pet dinosaur."
# using only String#slice() will
p "Before String#slice(): #{advice}"
advice.slice(0..38)
p "After String#slice(): #{advice}"

# using String#slice!() will permanently change advice
p "Before String#slice!(): #{advice}"
advice.slice!(0..38)
p "After String#slice!(): #{advice}"