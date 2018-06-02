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
  exit
end

rectangular = sides[2]**2 == sides[0]**2 + sides[1]**2

if  rectangular && sides[1] == sides[2]
  puts "Треугольник прямоугольный и равнобедренный"
elsif rectangular
  puts "Треугольник прямоугольный" 
else
  puts "Треугольник не прямоугольный."
end
