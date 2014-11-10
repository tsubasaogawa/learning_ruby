# encoding: cp932

class Hello
  def say(to)
    "Hello, #{to}!"
  end
end

class PoliteHello < Hello
  def say(to)
    super("Mr. #{to}")
  end
end

hello = PoliteHello.new
puts(hello.say("yamada"))
