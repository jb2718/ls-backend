class Greeting
  def greet(message)
    puts message
  end
end

class Hola < Greeting
  def hi
    greet('hola')
  end
end

class Adios < Greeting
  def bye
    greet('adios')
  end
end

hello = Hola.new
bye = Adios.new

hello.hi
bye.bye