class Student
  attr_accessor :name
  attr_writer :grade

  def initialize(n, g)
    @name = n
    @grade = g
  end

  def better_grade_than?(person)
    person.get_grade < self.get_grade
  end

  def get_grade
    self.grade
  end

  protected
  attr_reader :grade

end

bob = Student.new('Bob', 89)
joe = Student.new('Joe', 92)

puts "Well done!" if joe.better_grade_than?(bob)