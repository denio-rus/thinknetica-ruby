module Message

  def request_cargo_volume
    puts "Укажите грузоподьемность вагона (в тоннах):"
  end

  def request_number_of_seats
    puts "Укажите количество мест в вагоне:"
  end

  def operation_success_message
    puts "Операция выполнена"
  end

  def operation_rejected_message(e)
    puts e.message
    puts "Операция не выполнена"
  end

  def train_created_message(id)
    puts "Поезд #{id} создан."
  end

  def wrong_choise_message
    puts "Нет такого варианта"
  end

  def request_train_id_message
    print "Введите идентификатор поезда (***-**, где * - цифра или символ a-z, дефис опционален): "
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

  def trains_at(station)
     station.each_train { |train| puts "Поезд - #{train.id}, тип - #{train.type}, количество вагонов - #{train.number_of_wagons}"}
  end

  def train_detalization(train)
    puts "Поезд состоит из #{train.number_of_wagons} вагонов:"
    train.each_wagon do |wagon|
      print "Вагон номер - #{wagon.id}, тип - #{wagon.type}. "
      puts "Свободный объем - #{wagon.free_volume}, занятый объем - #{wagon.taken_volume}." if wagon.type == "cargo"
      puts "Свободно мест - #{wagon.free_seats}, занято мест - #{wagon.taken_seats}." if wagon.type == "passenger"
    end
  end

  def request_loading_volume
    puts "Введите объем загружаемого груза: "
  end
end
