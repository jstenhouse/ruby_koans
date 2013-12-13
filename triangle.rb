# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#
require 'set'

def triangle(a, b, c)
  validate_sides!(a, b, c)
  set = Set.new([a, b, c])
  case set.size
    when 1 then :equilateral
    when 2 then :isosceles
    else :scalene
  end
end

def validate_sides!(a, b, c)
  sides = [a, b, c]
  raise TriangleError if sides.min <= 0
  x, y, z = sides.sort
  raise TriangleError if x + y <= z
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
