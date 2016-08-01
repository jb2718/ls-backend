class Box
  @@count = 0

  def initialize(w, h)
    @width, @height = w, h
    @@count += 1
  end

  # getter methods
  def get_width
    @width
  end

  def get_height
    @height
  end

  # setter methods
  def set_width=(value)
    @width = value
  end

  def set_height=(value)
    @height = value
  end

  private :get_height, :get_width

  # instance methods
  def get_area
    get_width * get_height
  end

  protected :get_area

  def to_s
    "(w: #{get_width}, h: #{get_height})"
  end

  # class methods
  def self.print_count
    @@count
  end

end

box = Box.new(10,20)

# use setter methods
box.set_width = 30
box.set_height = 50

# # use accessor methods
# x = box.get_width
# y = box.get_height

# puts "The width of the box is: #{x}"
# puts "The height of the box is: #{y}"

# call instance methods
# puts "The area of the box is: #{box.get_area}"
puts "The string representation of box is: #{box}"


# call class methods
puts "The total number of boxes is: #{Box.print_count}"