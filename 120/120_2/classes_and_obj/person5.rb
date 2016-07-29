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

  def ==(obj)
    same_name = false
    same_name = self.name == obj.name
    if same_name
      "These two objects have the same name"
    else
      "These two objects do not have the same name"
    end
  end

  def to_s
    name
  end

  private

  def parse_full_name(name)
    @name_pieces = name.split
    @first_name = @name_pieces.first
    @last_name = @name_pieces.size > 1 ? @name_pieces.last : ''
  end

end

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"