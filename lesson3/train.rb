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
    @stations = [departure_point, destination_point]
  end

  def departure
    @stations.first
  end

  def destination
    @stations.last
  end

  def add(station)
    @stations.insert(-2, station)
  end

  def remove(station)
    unless [departure, destination].include?(station)
      @stations.delete(station)
    else
      puts "Эту станцию нельзя удалить из маршрута"
    end
  end

  def list_stations
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
    @route.stations.first.train_arrive(self)
  end

  def move_next
    if next_station
      current_station.train_departure(self)
      next_station.train_arrive(self)
      @current_station_index += 1
    else
      puts "Это конечная станция."
    end
  end

  def move_back
    if previous_station
      current_station.train_departure(self)
      previous_station.train_arrive(self)
      @current_station_index -= 1
    else
      puts "Это начальная станция маршрута."
    end
  end

  def current_station
    @route.stations[@current_station_index]
  end

  def next_station
    if @current_station_index == @route.stations.size - 1
      return nil
    else
      @route.stations[@current_station_index + 1]
    end
  end

  def previous_station
    if @current_station_index == 0
      return nil
    else
      @route.stations[@current_station_index - 1]
    end
  end
end
