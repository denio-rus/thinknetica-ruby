puts "Введите свое имя: "
name = gets.chomp

puts "Введите свой рост: "
height = gets.to_i

ideal_weight = height - 110

if ideal_weight < 0 
  puts "Ваш вес уже оптимальный"
else 
	puts "#{name}, ваш идельный вес: #{ideal_weight} кг."	
end
