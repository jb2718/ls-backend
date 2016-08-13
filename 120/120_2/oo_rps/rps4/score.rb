class Score
  attr_accessor :value
  MAX_VALUE = 10
  def initialize
    @value = 0
  end
  
  def increment
    @value += 1 if @value < MAX_VALUE
  end

  def maxed_out?
    @value >= MAX_VALUE
  end
  
  def reset
    @value = 0
  end

  def to_s
    "#{self.value}"
  end
end
