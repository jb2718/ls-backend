class Box
  attr_accessor :width, :height
  @@count = 0

  def initialize(w, h)
    @width, @height = w, h
    @@count += 1
  end

  def +(other_box)
    Box.new(@width + other_box.width, @height + other_box.height)
  end

  def -@
    Box.new(-@width, -@height)
  end

  def *(scalar)
    Box.new(@width*scalar, @height*scalar)
  end

  # instance methods
  def get_area
    width * height
  end

  def to_s
    "(w: #{width}, h: #{height})"
  end

  # class methods
  def self.print_count
    @@count
  end
end

class BigBox < Box
  def get_area
    @area = @width * @height
    puts "Big box area is: #{@area}"
  end
end

box = BigBox.new(10,20)
box2 = BigBox.new(3,5)

# use setter methods
box.width = 30
box.height = 50

# use accessor methods
x = box.width
y = box.height

puts "The width of the first box is: #{x}"
puts "The height of the first box is: #{y}"

a = box2.width
b = box2.height

puts "The width of the second box is: #{a}"
puts "The height of the second box is: #{b}"

# call instance methods
box.get_area
puts "The string representation of box is: #{box}"
box2.get_area
puts "The string representation of the second box is: #{box2}"

# call overridden methods
puts box + box2
puts box * 3
puts -box


# call class methods
puts "The total number of boxes is: #{Box.print_count}"