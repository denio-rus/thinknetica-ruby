class Interface
  include Message

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
      puts "5. Вывести имеющиеся станции"
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
      when 5
        show_stations
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
      puts "5. Вывести существующие поезда на экран."
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
      when 5
        show_trains
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
    if Station.find(name)
      station_name_taken_message
    else
      Station.new(name)
    end
    rescue RuntimeError => e
      operation_rejected_message(e)
  end

  def new_route
    request_route_id_message
    id = gets.chomp
    return id_taken_message if Route.find(id)

    print "Ввод станции отправления. "
    departure = get_station
    return wrong_station_name_message unless departure

    print "Ввод станции назначения. "
    destination = get_station
    return wrong_station_name_message unless destination

    Route.new(id, departure, destination)
  end

  def new_cargo_train
    begin
      request_train_id_message
      id = gets.chomp
      if Train.find(id)
        id_taken_message
      else
        CargoTrain.new(id)
      end
    rescue RuntimeError
      uncorrect_id_message
      retry
    end
    train_created_message(id)
  end

  def new_passenger_train
    begin
      request_train_id_message
      id = gets.chomp
      if Train.find(id)
        id_taken_message
      else
        PassengerTrain.new(id)
      end
    rescue RuntimeError
      uncorrect_id_message
      retry
    end
    train_created_message(id)
  end

  def new_wagon(id)
    request_wagon_type_message
    input = gets.to_i
    if input == 1
      CargoWagon.new(id)
    elsif input == 2
      PassengerWagon.new(id)
    else
      wrong_choise_message
    end
  end

  def add_station
    route = get_route
    return wrong_id_message unless route
    station = get_station
    return wrong_station_name_message unless station

    raise "Маршрут уже содержит данную станцию" if route.involve?(station)
    route.add(station)
    rescue RuntimeError => e
      operation_rejected_message(e)
  end

  def remove_station
    route = get_route
    return wrong_id_message  unless route
    station = get_station
    return wrong_station_name_message unless station

    raise "Указанная станция не найдена в маршруте" unless route.involve?(station)

    route.remove(station)
    rescue RuntimeError => e
      operation_rejected_message(e)
  end

  def show_routes
    route_detalization_message
  end

  def show_trains
    Train.all.each_pair { |id, train| puts "Поезд #{id} - тип #{train.type}" }
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
      wagon = new_wagon(id)
    end
    begin
      raise "Вагон используется в текущий момент" if wagon.status == "in use"
      train.wagon_add(wagon)
    rescue RuntimeError => e
      operation_rejected_message(e)
    end
    operation_success_message unless e
  end

  def remove_wagon
    train = get_train
    return wrong_id_message unless train

    request_wagon_id_message
    id = gets.chomp
    wagon = get_wagon(id)
    return wrong_id_message unless wagon

    begin
      train.wagon_remove(wagon)
    rescue RuntimeError => e
      operation_rejected_message(e)
    end
    operation_success_message unless e
  end

  def move_next
    train = get_train
    return wrong_id_message unless train

    train.move_next

    rescue RuntimeError => e
      operation_rejected_message(e)
  end

  def move_back
    train = get_train
    return wrong_id_message unless train

    train.move_back

    rescue RuntimeError => e
      operation_rejected_message(e)
  end

  def get_station
    request_station_name_message
    name = gets.chomp.capitalize
    Station.find(name)
  end

  def get_train
    request_train_id_message
    id = gets.chomp
    Train.find(id)
  end

  def get_route
    request_route_id_message
    id = gets.chomp
    Route.find(id)
  end

  def get_wagon(id)
    Wagon.find(id)
  end

  def show_stations
    Station.all.each_value { |station| puts station.name }
  end

  def list_train
    station = get_station
    trains_at(station) if station
  end
end
