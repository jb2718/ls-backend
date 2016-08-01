class Box
  attr_accessor :width, :height
  BOX_COMPANY = "TATA Inc"
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

box.freeze
if box.frozen?
  puts "box object is frozen"
else
  puts "box object is normal object"
end

# call constant
puts Box::BOX_COMPANY

# call overridden methods
puts box + box2
puts box * 3
puts -box


# call class methods
puts "The total number of boxes is: #{Box.print_count}"