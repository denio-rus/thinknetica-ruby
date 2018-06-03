fibonacci = [0]
next_number = 1

until next_number > 100
  fibonacci << next_number
  next_number = fibonacci[-1] + fibonacci[-2]
end
