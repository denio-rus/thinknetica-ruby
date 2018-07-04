class Route
  include InstanceCounter
  include ValidationMethods

  attr_reader :stations, :id
  # просто для того, чтобы маршрут начинался с буквы или цифры
  ROUTE_ID_FORMAT = /^[0-9A-Z]/i

  @@routes = {}

  def initialize(id, departure_point, destination_point)
    @id = id
    @stations = [departure_point, destination_point]
    validate!
    is_free?(id)
    register_instance
    @@routes[id] = self
  end

  def self.all
    @@routes
  end

  def add(station)
    validate_object(station, Station)
    raise "Маршрут уже содержит данную станцию" if @stations.include?(station)
    @stations.insert(-2, station)
  end

  def remove(station)
    raise "Указанная станция не найдена в маршруте" unless @stations.include?(station)
    if [departure, destination].include?(station)
      raise "Эту станцию нельзя удалить из маршрута"
    else
      @stations.delete(station)
    end
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

  def self.find(id)
    @@routes[id]
  end

  private

  def validate!
    validate_object(departure, Station)
    validate_object(destination, Station)
    raise "Станция отправления и станция назначения совпадают" if destination == departure # допустим у нас нет кольцевых маршрутов
    raise "Blank input" if id == nil
    raise "Argument type error" unless id.instance_of? String
    raise "Incorrect ID" if id !~ ROUTE_ID_FORMAT
  end
end
