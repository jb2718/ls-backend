class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

# @@cats_count is a class variable.  It does not belong to any particular object.  In this particular class,
# @@cats_count will be incremented every time a new Cat object is created.

puts Cat.cats_count
mao_mao = Cat.new('Tabby')
tiger = Cat.new('Grey')
puts Cat.cats_count