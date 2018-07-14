module Message
  def main_menu_message
    puts '9. Выход из программы'
    puts '1. Добавить объект'
    puts '2. Операции с маршрутами'
    puts '3. Операции с поездами'
    puts '4. Информация о станциях'
    print 'Введите номер операции: '
  end

  def menu_create_message
    puts '9. Назад в главное меню'
    puts '1. Создать станцию'
    puts '2. Создать маршрут'
    puts '3. Создать грузовой поезд'
    puts '4. Создать пассажирский поезд'
    print 'Введите номер операции: '
  end

  def menu_route_message
    puts '9. Назад в главное меню'
    puts '1. Добавить станцию в маршрут'
    puts '2. Удалить станцию из маршрута'
    puts '3. Назначить маршрут поезду'
    puts '4. Вывести имеющиеся маршруты'
    puts '5. Вывести имеющиеся станции'
    print 'Введите номер операции: '
  end

  def menu_train_message
    puts '9. Назад в главное меню.'
    puts '1. Добавить вагон к поезду.'
    puts '2. Отцепить вагон от поезда.'
    puts '3. Движение поезда на следующую станцию маршрута.'
    puts '4. Движение поезда на предыдущую станцию маршрута.'
    puts '5. Вывести существующие поезда на экран.'
    puts '6. Детальная информация о поезде.'
    puts '7. Добавить груз или пассажира в вагон.'
    print 'Введите номер операции: '
  end

  def menu_station_message
    puts '9. Назад в главное меню.'
    puts '1. Показать список станций.'
    puts '2. Список поездов на станции'
    puts '3. Максимальная загруженность станции.'
    print 'Введите номер операции: '
  end

  def request_cargo_volume
    puts 'Укажите грузоподьемность вагона (в тоннах):'
  end

  def request_number_of_seats
    puts 'Укажите количество мест в вагоне:'
  end

  def operation_success_message
    puts 'Операция выполнена'
  end

  def operation_rejected_message(e)
    puts e.message
    puts 'Операция не выполнена'
  end

  def train_created_message(id)
    puts "Поезд #{id} создан."
  end

  def wrong_choise_message
    puts 'Нет такого варианта'
  end

  def request_train_id_message
    print 'Введите идентификатор поезда (***-**, где * - цифра или символ a-z, дефис опционален): '
  end

  def request_wagon_id_message
    print 'Введите идентификатор вагона: '
  end

  def request_station_name_message
    print 'Введите название станции: '
  end

  def request_route_id_message
    print 'Введите идентификатор маршрута: '
  end

  def wrong_id_message
    puts 'Введен несуществующий идентификатор'
  end

  def wrong_station_name_message
    puts 'Введена несуществующая станция'
  end

  def route_detalization_message
    Route.all.each_pair do |id, route|
      puts "Идентификатор маршрута: #{id} "
      route.list_stations
      puts "\n"
    end
  end

  def request_wagon_type_message
    puts 'Выберите тип вагона (1 - cargo, 2 - passenger): '
  end

  def trains_at(station)
    station.each_train do |train|
      puts "Поезд - #{train.id}, тип - #{train.type}, " \
      "количество вагонов - #{train.number_of_wagons}"
    end
  end

  def train_detalization(train)
    puts "Поезд состоит из #{train.number_of_wagons} вагонов:"
    train.each_wagon do |wagon|
      print "Вагон номер - #{wagon.id}, тип - #{wagon.wagon_type}. "
      if wagon.wagon_type == 'cargo'
        puts "Свободный объем - #{wagon.free_capacity}, занятый объем" \
             " - #{wagon.capacity_in_use}."
      elsif wagon.wagon_type == 'passenger'
        puts "Свободно мест - #{wagon.free_capacity}, занято мест" \
             " - #{wagon.capacity_in_use}."
      end
    end
  end

  def request_loading_volume
    puts 'Введите объем загружаемого груза: '
  end

  def station_max_occupancy_message(station,number)
    puts "Максимальная загруженность станции #{station.name} составляет #{number} поезда(ов)."
  end
end
