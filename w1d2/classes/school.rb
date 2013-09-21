class Student
  attr_accessor :first,:last,:courses

  def initialize(first,last)
    @first = first
    @last = last
    @courses = []
  end

  def name
    "#{@first} #{@last}"
  end

  def enroll(add_course)
    self.courses.each do |course|
      raise "This course conflicts with a pre-existing one" if add_course.conflicts_with?(course)
    end
    unless @courses.include?(add_course)
      @courses << add_course
    else
    end
  end

  def course_load
    load = {}
    @courses.each do |course|
      if load.has_key?(course.department)
        load[course.department] += course.credits
      else
        load[course.department] = course.credits
      end
    end
    load
  end
end

class Course
  attr_accessor :name, :department, :students, :credits,:days_of_week, :time_block

  def initialize(name, department, credits, time_block,days_of_week)
    @name = name
    @department = department
    @credits = credits
    @students = []
    @time_block = time_block
    @days_of_week = days_of_week
  end

  def add_student(student)
    @students << student unless @students.include?(student)
  end

  def conflicts_with?(course2)
    if self.time_block == course2.time_block
      return self.days_of_week & course2.days_of_week
    else
      return false
    end
  end
end


c1 = Course.new("calc", "math", 4, 2, [:mon, :tues])
c2 = Course.new("calc 2", "math", 4, 1, [:mon, :tues])
c3 = Course.new("calc 3", "math", 4, 1, [:mon, :wed])


s = Student.new("john","doe")

s.enroll(c1)
s.enroll(c2)
#p s.enroll(c3)
p s.course_load

