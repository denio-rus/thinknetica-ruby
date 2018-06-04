basket = {}
loop  do
  print "Введите наименование товара: "
  purchase = gets.chomp
  break if purchase == "стоп"

  print "Введите цену товара: "
  price = gets.to_f

  print "Введите количество товара: "
  amount = gets.to_f

  basket[purchase] = { price: price, amount: amount }
end

puts basket
total = 0

basket.each do |purchase, data|
  cost = data[:price] * data[:amount]
  puts "Стоимость #{purchase} = #{cost} рублей"
  total += cost
end

puts "Всего потрачено #{total} рублей"
