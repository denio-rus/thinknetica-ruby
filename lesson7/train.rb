class Train
  include Production
  include InstanceCounter
  include ValidationMethods

  attr_reader :speed, :id, :type, :wagons, :route

  TRAIN_ID_FORMAT = /^[0-9a-z]{3}-?[0-9a-z]{2}$/i

  @@trains = {}

  def initialize(id)
    @id = id
    validate!
    is_free?(id) # использую отдельно от validate!, чтобы метод valid? работал
    @wagons = []
    @speed = 0
    @@trains[id] = self
    register_instance
  end

  def self.all
    @@trains
  end

  def decrease_speed(value)
    @speed -= value
    @speed = 0 if speed < 0
  end

  def increase_speed(value)
    @speed += value
  end

  def wagon_add(wagon)
     raise "Вагон используется в текущий момент" if wagon.status == "in use"
    if speed == 0
      @wagons << wagon
      wagon.set_in_use
    else
      raise "Поезд в движении, операция невозможна."
    end
  end

  def wagon_remove(wagon)
      if speed == 0 && @wagons.include?(wagon)
      @wagons.delete(wagon)
      wagon.set_free
    elsif speed != 0
      raise "Поезд в движении, операция невозможна."
    else
      raise "Данного вагона нет в составе"
    end
  end

  def take_route(route)
    validate_object(route, Route)
    @route = route
    @current_station_index = 0
    @route.stations.first.train_arrive(self)
  end

  def move_next
    raise "Маршрут не задан" unless @route

    if next_station
      current_station.train_departure(self)
      next_station.train_arrive(self)
      @current_station_index += 1
    else
      raise "Это конечная станция"
    end
  end

  def move_back
    raise "Маршрут не задан" unless @route

    if previous_station
      current_station.train_departure(self)
      previous_station.train_arrive(self)
      @current_station_index -= 1
    else
      raise "Это начальная станция"
    end
  end

  def self.find(id)
    @@trains[id]
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

  protected

  def validate!
    raise "Blank input" if @id == nil
    raise "Argument type error" unless @id.instance_of? String
    raise "Incorrect ID" if @id !~ TRAIN_ID_FORMAT
  end
end
