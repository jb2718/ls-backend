# person.rb

class Person
  attr_accessor :first_name, :last_name

  def initialize(name)
    parse_full_name(name)
  end

  def name
    "#{@first_name} #{last_name}".strip
  end

  def name=(name)
    parse_full_name(name)
  end

  private

  def parse_full_name(name)
    @name_pieces = name.split
    @first_name = @name_pieces.first
    @last_name = @name_pieces.size > 1 ? @name_pieces.last : ''
  end
end

bob = Person.new('Robert')
puts bob.name                  # => 'Robert'
puts bob.first_name            # => 'Robert'
puts bob.last_name             # => ''
bob.last_name = 'Smith'
puts bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
puts bob.first_name            # => 'John'
puts bob.last_name             # => 'Adams'