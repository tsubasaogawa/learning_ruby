# encoding: cp932

class Base
  def hello()
    puts("hello")
  end
end

class Derived < Base
  def hello()
    puts("hi")
  end
end

x = Derived.new
x.hello
