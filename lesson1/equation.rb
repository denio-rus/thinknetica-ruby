print "Введите коэффициенты квадратного уравнения \na: "
a = gets.to_f

print "b: "
b = gets.to_f

print "c: "
c = gets.to_f

discriminant = b**2 - 4 * a * c

if discriminant > 0
  discriminant_sqrt = Math.sqrt(discriminant)
  x1 = (-b + discriminant_sqrt)/(2 * a)
  x2 = (-b - discriminant_sqrt)/(2 * a)
  puts "Дискриминант (D = #{discriminant}) больше нуля, значит уравнение имеет два корня: х1= #{x1}  и х2 = #{x2}"
elsif discriminant == 0
  x = (-b)/(2 * a)
  puts "Дискриминант равен нулю, значит уравнение имеет один корень: #{x}"
else 
  puts "Дискриминант (D= #{discriminant}) меньше нуля, значит уравнение не имеет действительных корней"
end		
