# encoding: cp932

class Item
  def initialize(name, price)
    @name = name
	@price = price
  end
  
  def to_s
    "#{@name}, #{@price}, #{calc(@price)}"
  end

  def calc(price) 
    (price * 1.08).to_i
  end
end

class NoTaxItem < Item
  def calc(price)
    price
  end
end

[NoTaxItem.new("500 yen price card", 500), Item.new("Sweets", 100)].each() do |e|
  puts(e)
end
