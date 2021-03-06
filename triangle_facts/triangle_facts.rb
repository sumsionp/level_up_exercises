# Killer facts about triangles AWW YEAH
class Triangle
  attr_accessor :side_a, :side_b, :side_c

  def initialize(side_a, side_b, side_c)
    @side_a = side_a
    @side_b = side_b
    @side_c = side_c
  end

  def equilateral
    side_a == side_b && side_b == side_c
  end

  def isosceles
    [side_a, side_b, side_c].uniq.length == 2
  end

  def scalene
    if !(equilateral || isosceles)
      true
    else
      false
    end
  end

  def recite_facts
    puts 'This triangle is equilateral!' if equilateral
    puts 'This triangle is isosceles!' if isosceles
    puts 'This triangle is scalene and mathematically boring.' if scalene
    puts 'The angles of this triangle are ' + angles.join(', ')
    puts 'This triangle is also a right triangle!' if right?
    puts ''
  end

  def angles
    calculate_angles(side_a, side_b, side_c)
  end

  def right?
    angles.include? 90
  end

  def calculate_angles(a, b, c)
    [radians_to_degrees(Math.acos((b**2 + c**2 - a**2) / (2.0 * b * c))),
     radians_to_degrees(Math.acos((a**2 + c**2 - b**2) / (2.0 * a * c))),
     radians_to_degrees(Math.acos((a**2 + b**2 - c**2) / (2.0 * a * b)))]
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end
end

triangles = [
  [5, 5, 5],
  [5, 12, 13]
]

triangles.each do |sides|
  tri = Triangle.new(*sides)
  tri.recite_facts
end
