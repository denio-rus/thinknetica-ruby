print "Введите коэффициенты квадратного уравнения \na: "
a = gets.to_f

print "b: "
b = gets.to_f

print "c: "
c = gets.to_f

discriminant = (b**2 - 4*a*c)

if discriminant > 0
	x1 = (-b + Math.sqrt(discriminant))/(2*a)
	x2 = (-b - Math.sqrt(discriminant))/(2*a)
	puts "Дискриминант (D= #{discriminant}) больше нуля, значит уравнение имеет два корня: х1=" + x1.to_s + " и х2 =" + x2.to_s
elsif discriminant == 0
	puts "Дискриминант равен нулю, значит уравнение имеет один корень: #{(-b)/(2*a)}"
else 
	puts "Дискриминант (D= #{discriminant}) меньше нуля, значит уравнение не имеет действительных корней"
end
			