class CSSHelper

  def self.stock_colour(quantity)
    if quantity == 0
      return 'out-of-stock'
    elsif quantity <= 1
      return 'low-stock'
    else
      return 'in-stock'
    end
  end

  def self.no_objects
    return "N/A"
  end

end
