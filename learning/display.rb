# encoding: cp932

class Item
  def initialize(name, cost)
    @name = name
	@price = (cost / 0.6 * 1.05).to_i
  end
  
  attr_accessor :name
  attr_reader :price
end

item = Item.new("A", 600)
puts("A buyprice of #{item.name} is #{item.price} yen.")

item.name = "B"
puts("A buyprice of #{item.name} is #{item.price} yen.")
