module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

orange = Orange.new
orange.flavor('orange')
p Orange.ancestors
p HotSauce.ancestors