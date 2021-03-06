class Interface
  include Message

  def main_menu
    loop do
      main_menu_message
      input = gets.to_i

      case input
      when 1
        menu_create
      when 2
        menu_route
      when 3
        menu_train
      when 4
        menu_station
      when 9
        break
      else
        wrong_choise_message
      end
    end
  end

  def start
    seeds
    main_menu
  end

  # Все дальнейшие методы методы вызываются внутри объекта
  private

  def menu_create
    loop do
      menu_create_message
      input = gets.to_i

      case input
      when 1
        new_station
      when 2
        new_route
      when 3
        new_cargo_train
      when 4
        new_passenger_train
      when 9
        break
      else
        wrong_choise_message
      end
    end
  end

  def menu_route
    loop do
      menu_route_message
      input = gets.to_i

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
      when 9
        break
      else
        wrong_choise_message
      end
    end
  end

  def menu_train
    loop do
      menu_train_message
      input = gets.to_i

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
      when 6
        detail_train
      when 7
        load_wagon
      when 9
        break
      else
        wrong_choise_message
      end
    end
  end

  def menu_station
    loop do
      menu_station_message
      input = gets.to_i

      case input
      when 1
        show_stations
      when 2
        list_train
      when 9
        break
      else
        wrong_choise_message
      end
    end
  end

  def new_station
    request_station_name_message
    name = gets.chomp.capitalize
    Station.new(name)
    operation_success_message
  rescue RuntimeError => e
    operation_rejected_message(e)
  end

  def new_route
    request_route_id_message
    id = gets.chomp

    print 'Ввод станции отправления. '
    departure = get_station
    return wrong_station_name_message unless departure

    print 'Ввод станции назначения. '
    destination = get_station
    return wrong_station_name_message unless destination

    Route.new(id, departure, destination)
    operation_success_message
  rescue RuntimeError => e
    operation_rejected_message(e)
  end

  def new_cargo_train
    request_train_id_message
    id = gets.chomp
    CargoTrain.new(id)
    train_created_message(id)
  rescue RuntimeError => e
    operation_rejected_message(e)
    retry
  end

  def new_passenger_train
    request_train_id_message
    id = gets.chomp
    PassengerTrain.new(id)
    train_created_message(id)
  rescue RuntimeError => e
    operation_rejected_message(e)
    retry
  end

  def new_wagon(id)
    request_wagon_type_message
    input = gets.to_i
    if input == 1
      new_cargo_wagon(id)
    elsif input == 2
      new_passenger_wagon(id)
    else
      wrong_choise_message
    end
  end

  def new_cargo_wagon(id)
    request_cargo_volume
    cargo_volume = gets.to_f
    CargoWagon.new(id, cargo_volume)
  rescue RuntimeError => e
    operation_rejected_message(e)
  end

  def new_passenger_wagon(id)
    request_number_of_seats
    seats = gets.to_i
    PassengerWagon.new(id, seats)
  rescue RuntimeError => e
    operation_rejected_message(e)
  end

  def add_station
    route = get_route
    return wrong_id_message unless route
    station = get_station
    return wrong_station_name_message unless station

    route.add(station)
    operation_success_message
  rescue RuntimeError => e
    operation_rejected_message(e)
  end

  def remove_station
    route = get_route
    return wrong_id_message unless route
    station = get_station
    return wrong_station_name_message unless station

    route.remove(station)
    operation_success_message
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
    operation_success_message
  end

  def add_wagon
    train = get_train
    return wrong_id_message unless train

    request_wagon_id_message
    id = gets.chomp
    wagon = get_wagon(id)
    wagon ||= new_wagon(id)
    train.wagon_add(wagon)
    operation_success_message
  rescue RuntimeError => e
    operation_rejected_message(e)
  end

  def remove_wagon
    train = get_train
    return wrong_id_message unless train

    request_wagon_id_message
    id = gets.chomp
    wagon = get_wagon(id)
    return wrong_id_message unless wagon

    train.wagon_remove(wagon)
    operation_success_message
  rescue RuntimeError => e
    operation_rejected_message(e)
  end

  def move_next
    train = get_train
    return wrong_id_message unless train

    train.move_next
    operation_success_message
  rescue RuntimeError => e
    operation_rejected_message(e)
  end

  def move_back
    train = get_train
    return wrong_id_message unless train

    train.move_back
    operation_success_message
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

  def detail_train
    train = get_train
    train_detalization(train)
  end

  def load_wagon
    request_wagon_id_message
    id = gets.chomp
    wagon = get_wagon(id)
    return wrong_id_message unless wagon

    if wagon.type == 'cargo'
      request_loading_volume
      volume = gets.to_f
      wagon.load_item(volume)
    else
      wagon.load_item
    end
    operation_success_message
  rescue RuntimeError => e
    operation_rejected_message(e)
    retry
  end

  def seeds
    a = Station.new('Bos')
    b = Station.new('Los')

    CargoTrain.new('11111')
    PassengerTrain.new('22222')

    Route.new('r1', a, b)

  end
end
