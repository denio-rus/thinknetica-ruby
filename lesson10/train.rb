class Train
  include Production
  include InstanceCounter
  include Validation
  extend Accessors

  TRAIN_ID_FORMAT = /^[0-9a-z]{3}-?[0-9a-z]{2}$/i

  attr_reader :speed, :id, :type, :wagons, :route

  @@trains = {}

  validate :id, :presense
  validate :id, :format, TRAIN_ID_FORMAT
  validate :id, :uniqueness

  def self.all
    @@trains
  end

  def self.find(id)
    @@trains[id]
  end

  def initialize(id)
    @id = id
    validate!
    @wagons = []
    @speed = 0
    @@trains[id] = self
    register_instance
  end

  def number_of_wagons
    @wagons.size
  end

  def decrease_speed(value)
    self.speed -= value
    self.speed = 0 if speed < 0
  end

  def increase_speed(value)
    self.speed += value
  end

  def wagon_add(wagon)
    validate_type(wagon, Wagon)
    raise 'Вагон используется в текущий момент' if wagon.status == 'in use'
    raise 'Поезд в движении, операция невозможна.' unless speed.zero?
    @wagons << wagon
    wagon.set_in_use
  end

  def wagon_remove(wagon)
    if speed.zero? && @wagons.include?(wagon)
      @wagons.delete(wagon)
      wagon.set_free
    elsif speed != 0
      raise 'Поезд в движении, операция невозможна.'
    else
      raise 'Данного вагона нет в составе'
    end
  end

  def take_route(route)
    validate_type(route, Route)
    @route = route
    @current_station_index = 0
    @route.stations.first.train_arrive(self)
  end

  def move_next
    raise 'Маршрут не задан' unless @route
    raise 'Это конечная станция' unless next_station
    current_station.train_departure(self)
    next_station.train_arrive(self)
    @current_station_index += 1
  end

  def move_back
    raise 'Маршрут не задан' unless @route
    raise 'Это начальная станция' unless previous_station
    current_station.train_departure(self)
    previous_station.train_arrive(self)
    @current_station_index -= 1
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

  def each_wagon
    @wagons.each do |wagon|
      yield(wagon) if block_given?
    end
  end

  private
  strong_attr_writer(:speed, Numeric)
end
