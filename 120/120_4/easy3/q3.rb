class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

tabby = AngryCat.new(4, "Xiao Yu")
grey_one = AngryCat.new(5, "Bao Yu")

p tabby
p grey_one