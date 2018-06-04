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
full_year[1] = 29 if year % 4 == 0 && year % 100 != 0 || year % 400 == 0

full_month = 0
day_of_year = 0

full_month = full_year.first(month-1)

full_month.each { |days_in_month| day_of_year += days_in_month }

day_of_year += day
