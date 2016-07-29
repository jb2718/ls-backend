# person.rb

class Person
  attr_accessor :first_name, :last_name

  def initialize(name)
    @name_pieces = name.split
    @first_name = @name_pieces.first
    @last_name = @name_pieces.size > 1 ? @name_pieces.last : ''
  end

  def name
    puts "#{@first_name} #{last_name}".strip
  end
end

bob = Person.new('Robert')
bob.name                  # => 'Robert'
bob.first_name            # => 'Robert'
bob.last_name             # => ''
bob.last_name = 'Smith'
bob.name                  # => 'Robert Smith'