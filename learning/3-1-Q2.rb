# encoding: cp932

# 学生の合計点を比較して平均より上か下かを判断

class Student
  def initialize(name, nl, ma, en)
    @name = name
	@national_language = nl
	@math = ma
	@english = en
    @sum = @national_language + @math + @english
  end
  
  def compare_sum(average)
    if average < @sum
	  puts("#{@name}'s score is upper than the average")
	elsif average > @sum
	  puts("#{@name}'s score is lower than the average")
	else
	  puts("#{@name}'s score is equal to the average")
	end
  end
  attr_reader :sum
end

students = []
[["A", 80, 70, 40], ["B", 50, 30, 80], ["C", 10, 20, 30], ["D", 80, 40, 90], ["E", 40, 60, 50]].each() do |nm, nl, ma, en|
  students << Student.new(nm, nl, ma, en)
end

average = 0
students.each do |e|
  average += e.sum
end

average /= students.size

students.each do |e|
  e.compare_sum(average)
end
