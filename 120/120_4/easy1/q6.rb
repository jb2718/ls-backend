class Cube
  attr_reader :volume
  def initialize(volume)
    @volume = volume
  end
end

cubo = Cube.new(36)
p cubo.volume