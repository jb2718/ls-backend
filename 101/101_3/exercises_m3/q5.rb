def color_valid(color)
  return true if ["blue", "green"].include?(color)
  false
end

#OR

def color_valid(color)
  color == "blue" || color == "green"
end