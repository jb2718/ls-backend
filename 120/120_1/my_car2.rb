class MyCar
  attr_accessor :color, :model, :speed, :running
  attr_reader :year

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
    @running = true
  end

  def gas
    puts "Speeding up"
    @speed += 5
  end

  def brake
    puts "Slowing down"
    if @speed > 5
      @speed -= 5
    else
      @speed = 0
    end
  end

  def show_year
    puts "The car is a #{year} model"
  end

  def spray_paint(color)
    self.color = color
  end

  def show_color
    puts "The current color is #{color}"
  end

  def current_speed
    puts "The current speed is: #{speed}"
  end

  def turn_off
    puts "Turning car off"
    self.speed = 0
    self.running = false
  end

  def is_running?
    coda = 'running' if running == true
    coda = 'not running' if running == false
    puts "The car is " + coda
  end

  def to_s
    "This #{year} #{model} is #{color}"
  end

  def self.gas_mileage(gallons, miles)
    g_mileage = miles.to_f/gallons.to_f
    puts "Gas mileage is: #{g_mileage} miles per gallon"
  end
end

shirley = MyCar.new(2000, 'silver', 'Focus')
puts shirley

MyCar.gas_mileage(5,100)