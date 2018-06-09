class Station
  attr_reader :trains_at_station, :station_id

  def initialize(station_id)
    @station_id = station_id
    @trains_at_station = []
  end

  def trains_by_type
    passenger_trains = 0
    freight_trains = 0
    @trains_at_station.each do |train|
      passenger_trains += 1 if train.type == "passenger"
      freight_trains += 1 if train.type == "freight"
    end
    puts "На станции #{station_id} пассажирских поездов -  #{passenger_trains}, грузовых поездов - #{freight_trains}"
  end

  def train_arrive(train)
    @trains_at_station << train
  end

  def train_departure(train)
    @trains_at_station.delete(train)
  end
end

class Route
  def initialize(departure_point, destination_point)
    @departure_point = departure_point
    @destination_point = destination_point
    @waypoint = []
  end

  def add_waypoint(new_waypoint)
    @waypoint << new_waypoint
  end

  def remove_waypoint(unnecesary_point)
    @waypoint.delete(unnecesary_point)
  end

  def route
    @route = []
    @route << @departure_point
    @waypoint.each { |station| @route << station } if @waypoint.any?
    @route << @destination_point
  end
end


class Train
  attr_reader :type, :wagons
  attr_accessor :speed
  def initialize(train_id, type, wagons)
    @train_id = train_id
    @type = type
    @wagons = wagons
  end

  def brake
    self.speed = 0
  end

  def wagon_add
    if speed == 0
      @wagons += 1
    else
      puts "Поезд в движении, операция невозможна."
    end
  end

  def wagon_remove
    if speed == 0
      @wagons -= 1
    else
      puts "Поезд в движении, операция невозможна."
    end
  end

  def take_route(route)
    @current_route = route.route
    @current_station = 0
    @current_route.first.train_arrive(self)
  end

  def move_next
    if @current_station == @current_route.size - 1
      puts "Это конечная станция."
    else
      @current_route[@current_station].train_departure(self)
      @current_station += 1
      @current_route[@current_station].train_arrive(self)
    end
  end

  def move_back
    if @current_station == 0
      puts "Это начальная станция маршрута."
    else
      @current_route[@current_station].train_departure(self)
      @current_station -= 1
      @current_route[@current_station].train_arrive(self)
    end
  end

  def location
    if @current_station > 0
      puts "previous - #{@current_route[@current_station - 1].station_id}, current - #{@current_route[@current_station].station_id}, next - #{@current_route[@current_station + 1].station_id}"
    elsif @current_station == 0
      puts "current - #{@current_route[@current_station].station_id}, next - #{@current_route[@current_station + 1].station_id}"
    else
      puts "previous - #{@current_route[@current_station - 1].station_id}}, current - #{@current_route[@current_station].station_id}"
    end
  end
end
