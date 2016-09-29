require 'set'
class School
  AccessError = Class.new(StandardError)

  def initialize
    @store = Hash.new { |hash, key| hash[key] = SortedSet.new }
  end

  def add(name, grade)
    @store[grade].add(name)
  end

  def students(grade)
    @store[grade].to_a
  end

  def students_by_grade
    @store
      .sort
      .map do |grade, students|
        { grade: grade, students: students.to_a }
      end
  end

  def instance_exec
    raise_access_error
  end

  def instance_eval(*)
    raise_access_error
  end

  def instance_variable_set(*)
    raise_access_error
  end

  private

  def raise_access_error
    raise AccessError, 'too smart, huh?'
  end

  freeze
end

module BookKeeping
  VERSION = 3
end
