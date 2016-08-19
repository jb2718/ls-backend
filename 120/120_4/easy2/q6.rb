class Television
  def self.manufacturer
    # method logic
    puts "This is the class method"
  end

  def model
    # method logic
    puts "This is the instance method"
  end
end

Television.manufacturer

twenty_inch = Television.new
twenty_inch.model