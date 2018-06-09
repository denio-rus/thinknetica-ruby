class Station
  attr_reader :trains, :name
  def initialize(name)
    @name = name
    @trains = []
  end

  def trains_by_type(type)
    @trains.count { |train| train.type == type }
  end

  def train_arrive(train)
    @trains << train
  end

  def train_departure(train)
    @trains.delete(train)
  end
end

class Route
  attr_reader :stations
  def initialize(departure_point, destination_point)
    @departure_point = departure_point
    @destination_point = destination_point
    @stations = [@departure_point, destination_point]
  end

  def add_waypoint(new_waypoint)
    @stations.insert(-2, new_waypoint)
  end

  def remove_waypoint(unnecesary_point)
    if unnecesary_point != @departure_point && unnecesary_point != @destination_point
      @stations.delete(unnecesary_point)
    else
      puts "Эту станцию нельзя удалить из маршрута"
    end
  end

  def order
    @stations.each { |station| puts station.name }
  end

end


class Train
  attr_reader :type, :wagons, :speed
  def initialize(id, type, wagons)
    @id = id
    @type = type
    @wagons = wagons
    @speed = 0
  end

  def decrease_speed(value)
    @speed -= value
    @speed = 0 if speed < 0
  end

  def increase_speed(value)
    @speed += value
  end

  def wagon_add
    if speed == 0
      @wagons += 1
    else
      puts "Поезд в движении, операция невозможна."
    end
  end

  def wagon_remove
    if speed == 0 && @wagons > 0
      @wagons -= 1
    elsif speed != 0
      puts "Поезд в движении, операция невозможна."
    else
      puts "Нет вагонов для отцепки"
    end
  end

  def take_route(route)
    @route = route
    @current_station_index = 0
    route.stations.first.train_arrive(self)
  end

  def move_next
    if @current_station_index == @route.stations.size - 1
      puts "Это конечная станция."
    else
      @route.stations[@current_station_index].train_departure(self)
      @current_station_index += 1
      @route.stations[@current_station_index].train_arrive(self)
    end
  end

  def move_back
    if @current_station_index == 0
      puts "Это начальная станция маршрута."
    else
      @route.stations[@current_station_index].train_departure(self)
      @current_station_index -= 1
      @route.stations[@current_station_index].train_arrive(self)
    end
  end

  def current_station
    @route.stations[@current_station_index]
  end

  def next_station
    if @current_station_index == @route.stations.size - 1
      @route.stations[@current_station_index]
    else
      @route.stations[@current_station_index + 1]
    end
  end

  def previous_station
    if @current_station_index == 0
      @route.stations[@current_station_index]
    else
      @route.stations[@current_station_index - 1]
    end
  end

end
