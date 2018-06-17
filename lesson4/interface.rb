class Interface
  def initialize
    @stations = []
    @routes = []
    @trains = []
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
        puts "Нет такого варианта"
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
        puts "Нет такого варианта"
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
        puts "Нет такого варианта"
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
        puts "Нет такого варианта"
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
        puts "Нет такого варианта"
      end
    end
  end

  def new_station
    print "Введите название новой станции: "
    name = gets.chomp.capitalize
    if @stations.index { |station| station.name == name }
      puts "Это название уже используется"
    else
      @stations << Station.new(name)
    end
  end

  def new_route
    print "Введите идентификатор маршрута: "
    id = gets.chomp
    if @routes.index { |route| route.id == id }
      puts "Идентификатор уже используется"
      return
    end

    print "Ввод станции отправления. "
    departure = check_station

    print "Ввод станции назначения. "
    destination = check_station

    @routes << Route.new(id, departure, destination) if departure && destination
  end

  def new_cargo_train
    print "Введите идентификатор поезда: "
    id = gets.chomp
    if @trains.index { |train| train.id == id }
      puts "Идентификатор уже используется"
    else
      @trains << CargoTrain.new(id)
    end
  end

  def new_passenger_train
    print "Введите идентификатор поезда: "
    id = gets.chomp
    if @trains.index { |train| train.id == id }
      puts "Идентификатор уже используется"
    else
      @trains << PassengerTrain.new(id)
    end
  end

  def add_station
    return until route = check_route
    return until station = check_station

    if !route.stations.include?(station)
      route.add(station)
    else
      puts "Маршрут уже содержит данную станцию"
    end
  end

  def remove_station
    return until route = check_route
    return until station = check_station

    if route.stations.include?(station)
      route.remove(station)
    else
      puts "Указанная станция не найдена в маршруте"
    end
  end

  def show_routes
    @routes.each do |route|
      puts "Идентификатор маршрута: #{route.id} "
      route.list_stations
    end
  end

  def set_route
    return until route = check_route
    train = check_train
    train.take_route(route) if train && route
  end

  def add_wagon
    return until train  = check_train

    if train.instance_of?(CargoTrain)
      train.wagon_add(CargoWagon.new)
    else
      train.wagon_add(PassengerWagon.new)
    end
  end

  def remove_wagon
    train = check_train
    train.wagon_remove if train
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
    print "Введите идентификатор поезда: "
    id = gets.chomp
    verify = @trains.index { |train| train.id == id }
    if verify
      @trains[verify]
    else
      puts "Введен несуществующий идентификатор"
    end
  end

  def check_station
    print "Введите название станции: "
    name = gets.chomp.capitalize
    verify = @stations.index { |station| station.name == name }
    if verify
      @stations[verify]
    else
      puts "Введена несуществующая станция"
    end
  end

  def check_route
    print "Укажите идентификатор маршрута: "
    id = gets.chomp
    verify = @routes.index { |route| route.id == id }
    if verify
      @routes[verify]
    else
      puts "Указан несуществующий идентификатор"
    end
  end

  def show_stations
    @stations.each { |station| puts station.name }
  end

  def list_train
    station = check_station
    puts station.trains if station
  end
end
