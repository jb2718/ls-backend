module Validations
  def valid_stay?(input)
    case input.downcase
    when 's', 'stay'
      true
    end
  end

  def valid_hit?(input)
    case input.downcase
    when 'h', 'hit'
      true
    end
  end
end
