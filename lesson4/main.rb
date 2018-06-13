require_relative "station"
require_relative "route"
require_relative "train"
require_relative "cargo_train"
require_relative "passenger_train"
require_relative "cargo_wagon"
require_relative "passenger_wagon"

@stations = []
@station_index = 0

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

      case
      when input == 1
        menu_create
      when input == 2
        menu_route
      when input == 3
        menu_train
      when input == 4
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
      puts "Введите номер операции: "

      input = gets.to_i

      break if input == 0

      case
      when input == 1
        make_station
      when input == 2
        make_route
      when input == 3
        make_cargo_train
      when input == 4
        make_passenger_train
      else
        puts "Нет такого варианта"
      end
    end
  end

  def menu_route
    loop do
      puts "0. Назад в главное меню."
      puts "1. Добавить станцию в маршрут."
      puts "2. Удалить станцию из маршрута."
      puts "3. Назначить маршрут поезду."
      puts "Введите номер операции: "

      input = gets.to_i

      break if input == 0

      case
      when input == 1
        add_station
      when input == 2
        remove_station
      when input == 3
        set_route
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
      puts "Введите номер операции: "

      input = gets.to_i

      break if input == 0

      case
      when input == 1
        add_wagon
      when input == 2
        remove_wagon
      when input == 3
        move_next
      when input == 4
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
      puts "Введите номер операции: "

      input = gets.to_i

      break if input == 0

      case
      when input == 1
        list_stations
      when input == 2
        list_train
      else
        puts "Нет такого варианта"
      end
    end
  end

  private

  def make_station
    puts "Укажите название станции: "
    name = gets.chomp
    @stations[@station_index] << Station.new(name)
    @station_index += 1
    puts "Создана станция "
  end

  def list_stations
    @stations.each { |station| puts station }
  end

main_menu


