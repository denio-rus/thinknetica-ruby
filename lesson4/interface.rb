class Interface
  include Message

  def initialize
    @stations = []
    @routes = []
    @trains = []
    @wagons = []
  end

  def main_menu
    loop do
      puts "9. Выход из программы"
      puts "1. Добавить объект"
      puts "2. Операции с маршрутами"
      puts "3. Операции с поездами"
      puts "4. Информация о станциях"
      print "Введите номер операции: "

      input = gets.to_i

      break if input == 9

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
        wrong_choise_message
      end
    end
  end

  def start
    main_menu
  end

# Все дальнейшие методы методы вызываются внутри объекта
private

  def menu_create
    loop do
      puts "9. Назад в главное меню"
      puts "1. Создать станцию"
      puts "2. Создать маршрут"
      puts "3. Создать грузовой поезд"
      puts "4. Создать пассажирский поезд"
      print "Введите номер операции: "

      input = gets.to_i

      break if input == 9

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
        wrong_choise_message
      end
    end
  end

  def menu_route
    loop do
      puts "9. Назад в главное меню"
      puts "1. Добавить станцию в маршрут"
      puts "2. Удалить станцию из маршрута"
      puts "3. Назначить маршрут поезду"
      puts "4. Вывести имеющиеся маршруты"
      print "Введите номер операции: "

      input = gets.to_i

      break if input == 9

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
        wrong_choise_message
      end
    end
  end

  def menu_train
    loop do
      puts "9. Назад в главное меню."
      puts "1. Добавить вагон к поезду."
      puts "2. Отцепить вагон от поезда."
      puts "3. Движение поезда на следующую станцию маршрута."
      puts "4. Движение поезда на предыдущую станцию маршрута."
      print "Введите номер операции: "

      input = gets.to_i

      break if input == 9

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
        wrong_choise_message
      end
    end
  end

  def menu_station
    loop do
      puts "9. Назад в главное меню."
      puts "1. Показать список станций."
      puts "2. Список поездов на станции"
      print "Введите номер операции: "

      input = gets.to_i

      break if input == 9

      case input
      when 1
        show_stations
      when 2
        list_train
      else
        wrong_choise_message
      end
    end
  end

  def new_station
    request_station_name_message
    name = gets.chomp.capitalize
    if @stations.detect { |station| station.name == name }
      station_name_taken_message
    else
      @stations << Station.new(name)
    end
  end

  def new_route
    request_route_id_message
    id = gets.chomp
    return id_taken_message if @routes.detect { |route| route.id == id }

    print "Ввод станции отправления. "
    departure = get_station
    return wrong_station_name_message unless departure

    print "Ввод станции назначения. "
    destination = get_station
    return wrong_station_name_message unless destination

    @routes << Route.new(id, departure, destination)
  end

  def new_cargo_train
    request_train_id_message
    id = gets.chomp
    if @trains.detect { |train| train.id == id }
      id_taken_message
    else
      @trains << CargoTrain.new(id)
    end
  end

  def new_passenger_train
    request_train_id_message
    id = gets.chomp
    if @trains.detect { |train| train.id == id }
      id_taken_message
    else
      @trains << PassengerTrain.new(id)
    end
  end

  def new_wagon(id)
    request_wagon_type_message
    input = gets.to_i
    if input == 1
      @wagons << CargoWagon.new(id)
    elsif input == 2
      @wagons << PassengerWagon.new(id)
    else
      wrong_choise_message
    end
  end

  def add_station
    route = get_route
    return wrong_id_message unless route
    station = get_station
    return wrong_station_name_message unless station

    if route.involve?(station)
      route_operation_cancel_message("include")
    else
      route.add(station)
    end
  end

  def remove_station
    route = get_route
    return wrong_id_message  unless route

    station = get_station
    return wrong_station_name_message unless station

    return route_operation_cancel_message("not include") unless route.involve?(station)

    result = route.remove(station)
    route_operation_cancel_message("can't delete") if result == "can't delete"
  end

  def show_routes
    detalization(@routes)
  end

  def set_route
    route = get_route
    return wrong_id_message unless route

    train = get_train
    return wrong_id_message unless train

    train.take_route(route)
  end

  def add_wagon
    train = get_train
    return wrong_id_message unless train

    request_wagon_id_message
    id = gets.chomp
    wagon = get_wagon(id)
    unless wagon
      new_wagon(id)
      wagon = @wagons.last
    end

    return wagon_operation_cancel_message("in use") if wagon.status == "in use"

    result = train.wagon_add(wagon)
    wagon_operation_cancel_message("moving") if result == "moving"
    wagon_operation_cancel_message("type") if result == "type"
  end

  def remove_wagon
    train = get_train
    return wrong_id_message unless train

    request_wagon_id_message
    id = gets.chomp
    wagon = get_wagon(id)
    return wrong_id_message unless wagon

    result = train.wagon_remove(wagon)
    if result == "moving"
      wagon_operation_cancel_message("moving")
    elsif result == "type"
      wagon_operation_cancel_message("type")
    elsif result == "absence"
      wagon_operation_cancel_message("absence")
    end
  end

  def move_next
    train = get_train
    return wrong_id_message unless train

    result = train.move_next

    route_operation_cancel_message("no route") if result == "no route"
    route_operation_cancel_message("destination") if  result == "destination"
  end

  def move_back
    train = get_train
    return wrong_id_message unless train

    result = train.move_back

    route_operation_cancel_message("no route") if result == "no route"
    route_operation_cancel_message("departure") if result == "departure"
  end

  def get_train
    request_train_id_message
    id = gets.chomp
    verify = @trains.index { |train| train.id == id }
    @trains[verify] if verify
  end

  def get_station
    request_station_name_message
    name = gets.chomp.capitalize
    verify = @stations.index { |station| station.name == name }
    @stations[verify] if verify
  end

  def get_route
    request_route_id_message
    id = gets.chomp
    verify = @routes.index { |route| route.id == id }
    @routes[verify] if verify
  end

  def get_wagon(id)
    verify = @wagons.index { |wagon| wagon.id == id }
    @wagons[verify] if verify
  end

  def show_stations
    list_stations(@stations)
  end

  def list_train
    station = get_station
    trains_at(station) if station
  end
end
