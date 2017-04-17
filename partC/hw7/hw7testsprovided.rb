# University of Washington, Programming Languages, Homework 7, 
# hw7testsprovided.rb

require "./hw7.rb"

# Will not work completely until you implement all the classes and their methods

# Will print only if code has errors; prints nothing if all tests pass

# These tests do NOT cover all the various cases, especially for intersection

#Constants for testing
ZERO = 0.0
ONE = 1.0
TWO = 2.0
THREE = 3.0
FOUR = 4.0
FIVE = 5.0
SIX = 6.0
SEVEN = 7.0
EIGHT = 8.0
NINE = 9.0
TEN = 10.0

#Point Tests
a = Point.new(THREE,FIVE)
if not (a.x == THREE and a.y == FIVE)
	puts "Point is not initialized properly"
end
if not (a.eval_prog([]) == a)
	puts "Point eval_prog should return self"
end
if not (a.preprocess_prog == a)
	puts "Point preprocess_prog should return self"
end
a1 = a.shift(THREE,FIVE)
if not (a1.x == SIX and a1.y == TEN)
	puts "Point shift not working properly"
end
a2 = a.intersect(Point.new(THREE,FIVE))
if not (a2.x == THREE and a2.y == FIVE)
	puts "Point intersect not working properly"
end 
a3 = a.intersect(Point.new(FOUR,FIVE))
if not (a3.is_a? NoPoints)
	puts "Point intersect not working properly"
end
a4 = a.intersect(Line.new(ONE,TWO))
if not (a4.x == THREE and a4.y == FIVE)
	puts "Point intersect not working properlya: a4"
end
a5 = a.intersect(Line.new(FOUR,FIVE))
if not (a5.is_a? NoPoints)
	puts "Point intersect not working properly: a5"
end
a6 = a.intersect(VerticalLine.new(THREE))
if not (a6.x == THREE and a6.y == FIVE)
	puts "Point intersect not working properlya: a6"
end
a7 = a.intersect(VerticalLine.new(FOUR))
if not (a7.is_a? NoPoints)
	puts "Point intersect not working properly: a7"
end
a8 = a.intersect(LineSegment.new(FOUR, SIX, SIX, EIGHT))
if not (a8.is_a? NoPoints)
	puts "Point intersect not working properly: a8"
end
a9 = a.intersect(LineSegment.new(TWO, FOUR, FIVE, SEVEN))
if not (a9.x == THREE and a9.y == FIVE)
	puts "Point intersect not working properlya: a9"
end
a10 = a.intersect(LineSegment.new(ONE, FOUR, FIVE, SEVEN))
if not (a10.is_a? NoPoints)
	puts "Point intersect not working properlya: a10"
end

#Line Tests
b = Line.new(THREE,FIVE)
if not (b.m == THREE and b.b == FIVE)
	puts "Line not initialized properly"
end
if not (b.eval_prog([]) == b)
	puts "Line eval_prog should return self"
end
if not (b.preprocess_prog == b)
	puts "Line preprocess_prog should return self"
end
b1 = b.shift(THREE,FIVE) 
if not (b1.m == THREE and b1.b == ONE)
	puts "Line shift not working properly"
end

b2 = b.intersect(Line.new(THREE,FIVE))
if not (((b2.is_a? Line)) and b2.m == THREE and b2.b == FIVE)
	puts "Line intersect not working properly"
end
b3 = b.intersect(Line.new(THREE,FOUR))
if not ((b3.is_a? NoPoints))
	puts "Line intersect not working properly"
end
b4 = b.intersect(Line.new(TWO,SIX))
if not (b4.x == ONE and b4.y == EIGHT)
	puts "Line intersect not working properly: b4"
end
b5 = b.intersect(Point.new(ONE, EIGHT))
if not (b5.x == ONE and b5.y == EIGHT)
	puts "Line intersect not working properly: b5"
end
b6 = b.intersect(VerticalLine.new(ONE))
if not (b6.x == ONE and b6.y == EIGHT)
	puts "Line intersect not working properly: b6"
end
b7 = b.intersect(LineSegment.new(0.333333333, SIX, ONE, EIGHT))
if not (b7.y1 == SIX and b7.x2 == ONE and b7.y2 == EIGHT)
	puts "Line intersect not working properly: b7"
end

#VerticalLine Tests
c = VerticalLine.new(THREE)
if not (c.x == THREE)
	puts "VerticalLine not initialized properly"
end

if not (c.eval_prog([]) == c)
	puts "VerticalLine eval_prog should return self"
end
if not (c.preprocess_prog == c)
	puts "VerticalLine preprocess_prog should return self"
end
c1 = c.shift(THREE,FIVE)
if not (c1.x == SIX)
	puts "VerticalLine shift not working properly"
end
c2 = c.intersect(VerticalLine.new(THREE))
if not ((c2.is_a? VerticalLine) and c2.x == THREE )
	puts "VerticalLine intersect not working properly"
end
c3 = c.intersect(VerticalLine.new(FOUR))
if not ((c3.is_a? NoPoints))
	puts "VerticalLine intersect not working properly"
end
c4 = c.intersect(LineSegment.new(THREE, -ONE, THREE, FIVE))
if not (c4.x1 == THREE and c4.y1 == -ONE and c4.x2 == THREE and c4.y2 == FIVE)
	puts "VerticalLine intersect not working properly: c4"
end
c5 = c.intersect(LineSegment.new(THREE, -ONE, FOUR, FIVE))
if not (c5.x == THREE and c5.y == -ONE)
	puts "VerticalLine intersect not working properly: c5"
end
c6 = c.intersect(LineSegment.new(FOUR, -ONE, FIVE, FIVE))
if not ((c6.is_a? NoPoints))
	puts "VerticalLine intersect not working properly: c6"
end

#LineSegment Tests
d = LineSegment.new(ONE,TWO,-THREE,-FOUR)
if not (d.eval_prog([]) == d)
	puts "LineSegement eval_prog should return self"
end
d1 = LineSegment.new(ONE,TWO,ONE,TWO)
d2 = d1.preprocess_prog
if not ((d2.is_a? Point)and d2.x == ONE and d2.y == TWO) 
	puts "LineSegment preprocess_prog should convert to a Point"
	puts "if ends of segment are real_close"
end

d = d.preprocess_prog
if not (d.x1 == -THREE and d.y1 == -FOUR and d.x2 == ONE and d.y2 == TWO)
	puts "LineSegment preprocess_prog should make x1 and y1"
	puts "on the left of x2 and y2"
end

d3 = d.shift(THREE,FIVE)
if not (d3.x1 == ZERO and d3.y1 == ONE and d3.x2 == FOUR and d3.y2 == SEVEN)
	puts "LineSegment shift not working properly"
end

d4 = d.intersect(LineSegment.new(-THREE,-FOUR,ONE,TWO))
if not (((d4.is_a? LineSegment)) and d4.x1 == -THREE and d4.y1 == -FOUR and d4.x2 == ONE and d4.y2 == TWO)	
	puts "LineSegment intersect not working properly"
end
d5 = d.intersect(LineSegment.new(TWO,THREE,FOUR,FIVE))
if not ((d5.is_a? NoPoints))
	puts "LineSegment intersect not working properly"
end

d6 = (LineSegment.new(THREE, -ONE, THREE, FIVE)).intersect(c)
if not (d6.x1 == THREE and d6.y1 == -ONE and d6.x2 == THREE and d6.y2 == FIVE)
	puts "VerticalLine intersect not working properly: d6"
end
d7 = (LineSegment.new(THREE, -ONE, FOUR, FIVE)).intersect(c)
if not (d7.x == THREE and d7.y == -ONE)
	puts "VerticalLine intersect not working properly: d7"
end
d8 = (LineSegment.new(FOUR, -ONE, FIVE, FIVE)).intersect(c)
if not ((d8.is_a? NoPoints))
	puts "VerticalLine intersect not working properly: d8"
end
d9 = b.intersect(LineSegment.new(0.333333333, SIX, ONE, EIGHT))
if not (d9.y1 == SIX and d9.x2 == ONE and d9.y2 == EIGHT)
	puts "Line intersect not working properly: d9"
end

d10 = (LineSegment.new(FOUR, SIX, SIX, EIGHT)).intersect(a)
if not (d10.is_a? NoPoints)
	puts "Point intersect not working properly: d10"
end
d11 = (LineSegment.new(TWO, FOUR, FIVE, SEVEN)).intersect(a)
if not (d11.x == THREE and d11.y == FIVE)
	puts "Point intersect not working properlya: d11"
end
d12 = (LineSegment.new(ONE, FOUR, FIVE, SEVEN)).intersect(a)
if not (d12.is_a? NoPoints)
	puts "Point intersect not working properlya: d12"
end

#Intersect Tests
i = Intersect.new(LineSegment.new(-ONE,-TWO,THREE,FOUR), LineSegment.new(THREE,FOUR,-ONE,-TWO))
i1 = i.preprocess_prog.eval_prog([])
if not (i1.x1 == -ONE and i1.y1 == -TWO and i1.x2 == THREE and i1.y2 == FOUR)
	puts "Intersect eval_prog should return the intersect between e1 and e2"
end

#Var Tests
v = Var.new("a")
v1 = v.eval_prog([["a", Point.new(THREE,FIVE)]])
if not ((v1.is_a? Point) and v1.x == THREE and v1.y == FIVE)
	puts "Var eval_prog is not working properly"
end 
if not (v.preprocess_prog == v)
	puts "Var preprocess_prog should return self"
end

#Let Tests
l = Let.new("a", LineSegment.new(-ONE,-TWO,THREE,FOUR),
             Intersect.new(Var.new("a"),LineSegment.new(THREE,FOUR,-ONE,-TWO)))
l1 = l.preprocess_prog.eval_prog([])
if not (l1.x1 == -ONE and l1.y1 == -TWO and l1.x2 == THREE and l1.y2 == FOUR)
	puts "Let eval_prog should evaluate e2 after adding [s, e1] to the environment"
end

#Let Variable Shadowing Test
l2 = Let.new("a", LineSegment.new(-ONE, -TWO, THREE, FOUR),
              Let.new("b", LineSegment.new(THREE,FOUR,-ONE,-TWO), Intersect.new(Var.new("a"),Var.new("b"))))
l2 = l2.preprocess_prog.eval_prog([["a",Point.new(0,0)]])
if not (l2.x1 == -ONE and l2.y1 == -TWO and l2.x2 == THREE and l2.y2 == FOUR)
	puts "Let eval_prog should evaluate e2 after adding [s, e1] to the environment"
end


#Shift Tests
s = Shift.new(THREE,FIVE,LineSegment.new(THREE,FOUR, -ONE,-TWO))
s1 = s.preprocess_prog.eval_prog([])
if not (s1.x1 == TWO and s1.y1 == THREE and s1.x2 == SIX and s1.y2 == 9)
	puts "Shift should shift e by dx and dy"
end



