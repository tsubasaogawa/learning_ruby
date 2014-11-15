# encoding: cp932

def find_student(students, name)
  i = students.find_index() do |e|
    e.name == name
  end
  if i
    students[i]
  else
    nil
  end
end

class Student
  def initialize(name)
    @name = name
  end
  
  attr_reader :name
end


students = [Student.new("A"), Student.new("B"), Student.new("C"), Student.new("D")]
["A", "X", "C"].each() do |name|
  student = find_student(students, name)
  if student
    puts("Mr.#{name} lives here.")
  else
    puts("Mr.#{name} does not live here.")
  end
end
