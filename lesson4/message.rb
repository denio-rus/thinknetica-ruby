module Message

  def wrong_choise_message
    puts "Нет такого варианта"
  end

  def id_taken_message
    puts "Идентификатор уже используется"
  end

  def request_train_id_message
    print "Введите идентификатор поезда: "
  end

  def request_wagon_id_message
    print "Введите идентификатор вагона: "
  end

  def request_station_name_message
    print "Введите название станции: "
  end

  def request_route_id_message
    print "Введите идентификатор маршрута: "
  end

  def wrong_id_message
    puts "Введен несуществующий идентификатор"
  end

  def wrong_station_name_message
    puts "Введена несуществующая станция"
  end

  def station_name_taken_message
    puts "Это название уже используется"
  end

  def route_detalization_message
    Route.all.each_pair do |id, route|
      puts "Идентификатор маршрута: #{id} "
      route.list_stations
      puts "\n"
    end
  end

  def request_wagon_type_message
    puts "Выберите тип вагона (1 - cargo, 2 - passenger): "
  end

   def wagon_operation_cancel_message(error)
    case error
    when "type"
      puts "Тип вагона не соответствуют типу поезда"
    when "moving"
      puts "Поезд в движении, операция невозможна."
    when "absence"
      puts "Данного вагона нет в составе"
    when "in use"
      puts "Вагон используется в текущий момент"
    end
  end

  def route_operation_cancel_message(error)
    case error
    when "no route"
      puts "Маршрут не задан"
    when "departure"
      puts "Это начальная станция"
    when "destination"
      puts "Это конечная станция"
    when "include"
      puts "Маршрут уже содержит данную станцию"
    when "not include"
      puts "Указанная станция не найдена в маршруте"
    when "can't delete"
      puts "Эту станцию нельзя удалить из маршрута"
    end
  end

  def trains_at(station)
     station.trains.each { |train| puts "Поезд #{train.id} - тип #{train.type}"}
  end
end
