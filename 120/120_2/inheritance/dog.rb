class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
end

class BullDog < Dog
  def swim
    "can't swim!"  
  end
end

teddy = Dog.new
puts teddy.speak
puts teddy.swim

frank = BullDog.new
puts frank.speak
puts frank.swim