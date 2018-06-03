print "Введите день: "
day = gets.to_i

print "Введите месяц: "
month = gets.to_i

print "Введите год: "
year = gets.to_i

if month == 1
  day_of_year = day
  exit
end

full_year = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
full_year[1] = 29 if year % 4  == 0 && year % 100 != 0 || year % 400 == 0

# до того как узнал на codecademy оператор % сделал довольно громоздкую конструкцию, основываясь на информации из первой лекции про особенности деления
#full_year[1] = 29 if year / 4.0 - year / 4 == 0 && year / 100.0 - year / 100 != 0 || year / 400.0 - year / 400 == 0
#но она тоже работает

full_month = 0
day_of_year = 0

while full_month < month - 1
  day_of_year += full_year[full_month]
  full_month += 1
end

day_of_year += day
