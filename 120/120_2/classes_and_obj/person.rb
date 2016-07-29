# person.rb

class Person

  def initialize(name)
    @name = name
  end

  def name=(name)
    @name = name
  end

  def name
    puts "#{@name}"
  end
end

bob = Person.new('bob')
bob.name                  # => 'bob'
bob.name = 'Robert'
bob.name                  # => 'Robert'