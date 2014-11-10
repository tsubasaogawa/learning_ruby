# encoding: cp932

class Hello
  def initialize(obj)
    @obj = obj
  end
  def hello()
    puts(@obj.create_message())
  end
end

class EnglishHello
  def create_message()
    "hello"
  end
end

class JapaneseHello
  def create_message()
    "Kon nichi wa"
  end
end

j = Hello.new(JapaneseHello.new)
j.hello
e = Hello.new(EnglishHello.new)
e.hello
