require_relative "station"
require_relative "route"
require_relative "train"
require_relative "cargo_train"
require_relative "passenger_train"
require_relative "cargo_wagon"
require_relative "passenger_wagon"

def main_menu
  loop do
    puts "0. Выход из программы"
    puts "1. Добавить объект"
    puts "2. Операции с маршрутами"
    puts "3. Операции с поездами"
    puts "4. Информация о станциях"
    print "Введите номер операции: "

    input = gets.to_i

    break if input == 0

    case input
    when 1
      menu_create
    when 2
      menu_route
    when 3
      menu_train
    when 4
      menu_station
    else
      puts "Нет такого варианта"
    end
  end
end

def menu_create
  loop do
    puts "0. Назад в главное меню"
    puts "1. Создать станцию"
    puts "2. Создать маршрут"
    puts "3. Создать грузовой поезд"
    puts "4. Создать пассажирский поезд"
    print "Введите номер операции: "

    input = gets.to_i

    break if input == 0

    case input
    when 1
      new_station
    when 2
      new_route
    when 3
      new_cargo_train
    when 4
      new_passenger_train
    else
      puts "Нет такого варианта"
    end
  end
end

def menu_route
  loop do
    puts "0. Назад в главное меню"
    puts "1. Добавить станцию в маршрут"
    puts "2. Удалить станцию из маршрута"
    puts "3. Назначить маршрут поезду"
    puts "4. Вывести имеющиеся маршруты"
    print "Введите номер операции: "

    input = gets.to_i

    break if input == 0

    case input
    when 1
      add_station
    when 2
      remove_station
    when 3
      set_route
    when 4
      show_routes
    else
      puts "Нет такого варианта"
    end
  end
end

def menu_train
  loop do
    puts "0. Назад в главное меню."
    puts "1. Добавить вагон к поезду."
    puts "2. Отцепить вагон от поезда."
    puts "3. Движение поезда на следующую станцию маршрута."
    puts "4. Движение поезда на предыдущую станцию маршрута."
    print "Введите номер операции: "

    input = gets.to_i

    break if input == 0

    case input
    when 1
      add_wagon
    when 2
      remove_wagon
    when 3
      move_next
    when 4
      move_back
    else
      puts "Нет такого варианта"
    end
  end
end

def menu_station
  loop do
    puts "0. Назад в главное меню."
    puts "1. Показать список станций."
    puts "2. Список поездов на станции"
    print "Введите номер операции: "

    input = gets.to_i

    break if input == 0

    case input
    when 1
      show_stations
    when 2
      list_train
    else
      puts "Нет такого варианта"
    end
  end
end

def new_station
  print "Введите название новой станции: "
  name = gets.chomp.capitalize
  $stations << Station.new(name)
end

def show_stations
  $stations.each { |station| puts station.name }
end

def new_route
  print "Введите станцию отправления: "
  departure= gets.chomp.capitalize

  print "Введите станцию назначения: "
  destination = gets.chomp.capitalize

  if check_station(departure) && check_station(destination)
    first_station = $stations[check_station(departure)]
    last_station = $stations[check_station(destination)]
    $routes << Route.new(first_station, last_station)
  else
    puts "Введена несуществующая станция"
  end
end

def check_station(name)
  $stations.index { |station| station.name == name }
end

def show_routes
  $routes.each { |route| puts route.list_stations }
end

$routes = []
$stations = []

main_menu



