puts "Введите сторону a: "
side_a = gets.to_f

puts "Введите сторону b: "
side_b = gets.to_f

puts "Введите сторону c: "
side_c = gets.to_f

if side_a > side_b && side_a > side_c && side_a**2 == side_b**2 + side_c**2
	puts "Прямоугольный треугольник с гипотенузой а."
elsif side_b > side_a && side_b > side_c && side_b**2 == side_a**2 + side_c**2
	puts "Прямоугольный треугольник с гипотенузой b."
elsif side_c > side_a && side_c > side_b && side_c**2 == side_a**2 + side_b**2
	puts "Прямоугольный треугольник с гипотенузой c."
else
	puts "Треугольник не прямоугольный."
end

puts "Треугольник равнобедренный." if side_a == side_b || side_b == side_c || side_c == side_a

puts "Треугольник равнобедренный, равносторонний, но не прямоугольный." if side_a == side_b && side_b== side_c

