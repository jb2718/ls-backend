class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  # def make_one_year_older
  #   self.age += 1
  # end

  def make_one_year_older
    @age += 1
  end
end

brody = Cat.new("siamese")
puts brody.age
brody.make_one_year_older
puts brody.age