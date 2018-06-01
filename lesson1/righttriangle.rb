sides = []

puts "Введите сторону a: "
sides << gets.to_f

puts "Введите сторону b: "
sides << gets.to_f

puts "Введите сторону c: "
sides << gets.to_f

sides.sort!

if sides[0] == sides[1] && sides[1] == sides[2]
  puts "Треугольник равносторонний и равнобедренный, но не прямоугольный"
elsif  sides[2]**2 == sides[0]**2 + sides[1]**2
	puts "Треугольник прямоугольный"
  puts "Треугольник равнобедренный." if sides[0] == sides[1] || sides[1] == sides[2] || sides[0] == sides[2]
else
	puts "Треугольник не прямоугольный."
end
