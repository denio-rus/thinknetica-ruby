module Message

  def wrong_choise
    puts "Нет такого варианта"
  end

  def id_busy
    puts "Идентификатор уже используется"
  end

  def request_train_id
    print "Введите идентификатор поезда: "
    gets.chomp
  end

  def request_wagon_id
    print "Введите идентификатор вагона: "
    gets.chomp
  end

  def request_station_name
    print "Введите название станции: "
    gets.chomp.capitalize
  end

  def request_route_id
    print "Введите идентификатор маршрута: "
    gets.chomp
  end

  def wrong_id
    puts "Введен несуществующий идентификатор"
  end

  def wrong_station_name
    puts "Введена несуществующая станция"
  end

  def station_name_busy
    puts "Это название уже используется"
  end

  def routes(routes)
    routes.each do |route|
      puts "Идентификатор маршрута: #{route.id} "
      route.list_stations
      puts "\n"
    end
  end

  def request_wagon_type
    puts "Выберите тип вагона (1 - cargo, 2 - passenger): "
    gets.to_i
  end

   def wagon_operation_cancel(error)
    case error
    when "type"
      puts "Тип вагона не соответствуют типу поезда"
    when "moving"
      puts "Поезд в движении, операция невозможна."
    when "absence"
      puts "Нет данного вагона"
    when "in use"
      puts "Вагон используется в текущий момент"
    end
  end

  def route_operation_cancel(error)
    case error
    when "absence"
      puts "Маршрут не задан"
    when "departure"
      puts "Это начальная станция"
    when "destination"
      puts "Это конечная станция"
    when "include"
      puts "Маршрут уже содержит данную станцию"
    when "not include"
      puts "Указанная станция не найдена в маршруте"
    when "delete"
      puts "Эту станцию нельзя удалить из маршрута"
    end
  end

  def list_stations(stations)
    stations.each { |station| puts station.name }
  end

  def trains_at(station)
     station.trains.each { |train| puts "Поезд #{train.id} - тип #{train.type}" }
  end
end
