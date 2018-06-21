class Interface
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
      when 5
        p @stations
      when 6
        p @trains
      when 7
        p @routes
      when 8
        p @wagons
      else
        Message.wrong_choise
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
        Message.wrong_choise
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
        Message.wrong_choise
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
        Message.wrong_choise
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
        Message.wrong_choise
      end
    end
  end

  def new_station
    name = Message.request_station_name
    if @stations.index { |station| station.name == name }
      Message.station_name_busy
    else
      @stations << Station.new(name)
    end
  end

  def new_route
    id = Message.request_route_id
    if @routes.index { |route| route.id == id }
      Message.id_busy
      return
    end

    print "Ввод станции отправления. "
    departure = check_station

    print "Ввод станции назначения. "
    destination = check_station

    @routes << Route.new(id, departure, destination) if departure && destination
  end

  def new_cargo_train
    id = Message.request_train_id
    if @trains.index { |train| train.id == id }
      Message.id_busy
    else
      @trains << CargoTrain.new(id)
    end
  end

  def new_passenger_train
    id = Message.request_train_id
    if @trains.index { |train| train.id == id }
      Message.id_busy
    else
      @trains << PassengerTrain.new(id)
    end
  end

  def new_wagon(id)
    input = Message.request_wagon_type
    if input == 1
      @wagons << CargoWagon.new(id)
    elsif input == 2
      @wagons << PassengerWagon.new(id)
    else
      Message.wrong_choise
    end
  end

  def add_station
    return until route = check_route
    return until station = check_station

    if !route.stations.include?(station)
      route.add(station)
    else
      Message.route_operation_cancel("include")
    end
  end

  def remove_station
    return until route = check_route
    return until station = check_station

    if route.stations.include?(station)
      route.remove(station)
    else
      Message.route_operation_cancel("not include")
    end
  end

  def show_routes
    Message.routes(@routes)
  end

  def set_route
    return until route = check_route
    train = check_train
    train.take_route(route) if train && route
  end

  def add_wagon
    return until train = check_train
    id = Message.request_wagon_id
    wagon = check_wagon(id)
    until wagon
      new_wagon(id)
      wagon = @wagons.last
    end
    if wagon.status == "in use"
      Message.wagon_operation_cancel("in use")
      return
    else
      train.wagon_add(wagon)
    end
  end

  def remove_wagon
    train = check_train
    until train
      Message.wrong_id
      return
    end

    id = Message.request_wagon_id
    wagon = check_wagon(id)

    train.wagon_remove(wagon)
  end

  def move_next
    train = check_train
    train.move_next if train
  end

  def move_back
    train = check_train
    train.move_back if train
  end

  def check_train
    id = Message.request_train_id
    verify = @trains.index { |train| train.id == id }
    if verify
      @trains[verify]
    else
      Message.wrong_id
    end
  end

  def check_station
    name = Message.request_station_name
    verify = @stations.index { |station| station.name == name }
    if verify
      @stations[verify]
    else
      Message.wrong_station_name
    end
  end

  def check_route
    id = Message.request_route_id
    verify = @routes.index { |route| route.id == id }
    if verify
      @routes[verify]
    else
      Message.wrong_id
    end
  end

  def check_wagon(id)
    verify = @wagons.index { |wagon| wagon.id == id }
    @wagons[verify] if verify
  end

  def show_stations
    Message.list_stations(@stations)
  end

  def list_train
    station = check_station
    Message.trains_at(station) if station
  end
end
