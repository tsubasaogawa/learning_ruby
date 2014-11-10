# encoding: cp932

class Accumulator
  def initialize()
    @total = 0
  end
  
  def add(n)
    @total += n
  end
  
  def to_s()
    "#{@total}"
  end	
end

acm = Accumulator.new()
acm.add(10)
acm.add(1)
puts("10 + 1 = #{acm}")
