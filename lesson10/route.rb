class Route
  include InstanceCounter
  include Validation
  extend Accessors

  ROUTE_ID_FORMAT = /^[0-9A-Z]/i

  attr_reader :stations, :id

  @@routes = {}

  validate :id, :presense
  validate :id, :format, ROUTE_ID_FORMAT
  validate :id, :uniqueness
  validate :departure, :type, Station
  validate :destination, :type, Station

  def self.all
    @@routes
  end

  def self.find(id)
    @@routes[id]
  end

  def initialize(id, departure_point, destination_point)
    @id = id
    @stations = [departure_point, destination_point]
    validate!
    raise 'Станция отправления и станция назначения совпадают' if destination == departure
    register_instance
    @@routes[id] = self
  end

  def add(station)
    validate_type(station, Station)
    raise 'Маршрут уже содержит данную станцию' if @stations.include?(station)
    @stations.insert(-2, station)
  end

  def remove(station)
    raise 'Указанная станция не найдена в маршруте' unless @stations.include?(station)
    raise 'Эту станцию нельзя удалить из маршрута' if [departure, destination].include?(station)
    @stations.delete(station)
  end

  def list_stations
    @stations.each { |station| print "#{station.name} " }
  end

  def departure
    @stations.first
  end

  def destination
    @stations.last
  end
end
