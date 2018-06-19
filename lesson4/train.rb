class Train
  attr_reader :speed, :id, :type, :wagons

  def initialize(id)
    @id = id
    @wagons = []
    @speed = 0
  end

  def decrease_speed(value)
    @speed -= value
    @speed = 0 if speed < 0
  end

  def increase_speed(value)
    @speed += value
  end

  def wagon_add(wagon)
    return "Тип вагона не соответствует поезду" until self.type == wagon.type

    if speed == 0
      @wagons << wagon
    else
      "Поезд в движении, операция невозможна."
    end
  end

  def wagon_remove(wagon)
    if speed == 0 && @wagons.include?(wagon)
      @wagons.delete(wagon)
    elsif speed != 0
      puts "Поезд в движении, операция невозможна."
    else
      puts "Нет вагонов для отцепки"
    end
  end

  def take_route(route)
    @route = route
    @current_station_index = 0
    @route.stations.first.train_arrive(self)
  end

  def move_next
    until @route
      puts "Маршрут не задан"
      return
    end

    if next_station
      current_station.train_departure(self)
      next_station.train_arrive(self)
      @current_station_index += 1
    else
      puts "Это конечная станция."
    end
  end

  def move_back
    until @route
      puts "Маршрут не задан"
      return
    end

    if previous_station
      current_station.train_departure(self)
      previous_station.train_arrive(self)
      @current_station_index -= 1
    else
      puts "Это начальная станция маршрута."
    end
  end

  def involve?(wagon)
    @wagons.include?(wagon)
  end

  def current_station
    @route.stations[@current_station_index]
  end

  def next_station
    @route.stations[@current_station_index + 1] if @current_station_index != @route.stations.size - 1
  end

  def previous_station
    @route.stations[@current_station_index - 1] if @current_station_index != 0
  end
end
