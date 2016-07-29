PRODUCTS = [
  { name: "Thinkpad x210", price: 220 },
  { name: "Thinkpad x220", price: 250 },
  { name: "Thinkpad x250", price: 979 },
  { name: "Thinkpad x230", price: 300 },
  { name: "Thinkpad x230", price: 330 },
  { name: "Thinkpad x230", price: 350 },
  { name: "Thinkpad x240", price: 700 },
  { name: "Macbook Leopard", price: 300 },
  { name: "Macbook Air", price: 700 },
  { name: "Macbook Pro", price: 600 },
  { name: "Macbook", price: 1449 },
  { name: "Dell Latitude", price: 200 },
  { name: "Dell Latitude", price: 650 },
  { name: "Dell Inspiron", price: 300 },
  { name: "Dell Inspiron", price: 450 },
]

query = {
  price_min: 240,
  price_max: 280,
  q: "thinkpad"
}

query2 = {
  price_min: 300,
  price_max: 450,
  q: "dell"
}

def search(query)
  results = []
  results = PRODUCTS.select do |product| 
    product[:name].downcase.include?(query[:q]) &&
    (query[:price_min]..query[:price_max]).include?(product[:price])
  end
  p results
end

search(query)
# => [ { name: "Thinkpad x220", price: 250 }]
puts "\n\n"
search(query2)
# => [ { name: "Dell Inspiron", price: 300 }, { name: "Dell Inspiron", price: 450 }]