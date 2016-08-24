class Score
  attr_accessor :value
  MAX_VALUE = 10
  def initialize
    @value = 0
  end

  def increment
    self.value += 1 if @value < MAX_VALUE
  end

  def maxed_out?
    value >= MAX_VALUE
  end

  def reset
    self.value = 0
  end

  def to_s
    self.value.to_s
  end
end
