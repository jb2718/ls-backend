class Vehicle
  attr_accessor :speed, :heading

  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    @fuel_efficiency = km_traveled_per_liter
    @fuel_capacity = liters_of_fuel_capacity
  end

  def range
    @fuel_capacity * @fuel_efficiency
  end
end

module WheeledVehicle

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
end

class Motorcycle < Vehicle
  include WheeledVehicle

  def initialize
    # 2 tires are various tire pressures
    super(80, 8.0)
    @tire_array = [20,20]
  end
end

class Auto < Vehicle
  include WheeledVehicle

  def initialize
    #4 tires are various tire pressures
    super(50, 25.0)
    @tire_array = [30,30,32,32]
  end
end

class Catamaran < Vehicle
  attr_accessor :propeller_count, :hull_count

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    super(km_traveled_per_liter, liters_of_fuel_capacity)
    @propeller_count = num_propellers
    @hull_count = num_hulls
  end
end

boat = Catamaran.new(3,4,5,6.0)
p boat

car = Auto.new
p car

moto_che = Motorcycle.new
p moto_che