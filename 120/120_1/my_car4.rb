module Convertible
  def let_top_down
    "Letting top down..."
  end
end

class Vehicle
  attr_accessor :color, :model, :speed, :running
  attr_reader :year

  @@num_vehicles = 0

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
    @running = true
    @@num_vehicles += 1
  end

  def self.show_num_vehicles
    "Number of vehicles on the road: #{@@num_vehicles}"
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
    puts "This is a #{year} model"
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
    puts "Turning off"
    self.speed = 0
    self.running = false
  end

  def is_running?
    coda = 'running' if running == true
    coda = 'not running' if running == false
    puts "The car is " + coda
  end

  def self.gas_mileage(gallons, miles)
    g_mileage = miles.to_f/gallons.to_f
    puts "Gas mileage is: #{g_mileage} miles per gallon"
  end

  def to_s
    "This #{year} #{model} is #{color}"
  end

  def age
    now = Time.new.year
    puts "The vehicle is #{get_age(now)} years old"
  end

  private

  def get_age(current_year)
    current_year - self.year
  end 
end

class MyCar < Vehicle
  TRUNK_SPACE = 8
  include Convertible
end

class MyTruck < Vehicle
  FLATBED_SIZE = 10
end

car = MyCar.new(2000, "silver", "Ford Focus")
truck = MyTruck.new(2011, "black", "Volvo")
puts car
puts car.let_top_down
car.gas
car.current_speed
car.gas
car.brake
car.is_running?
car.current_speed
car.age
puts Vehicle.show_num_vehicles


puts "-------------------------"
puts truck
truck.gas
truck.current_speed
truck.gas
truck.brake
truck.is_running?
truck.current_speed
truck.turn_off
truck.current_speed
truck.show_color
truck.spray_paint('green')
truck.show_color
truck.age
puts Vehicle.show_num_vehicles
