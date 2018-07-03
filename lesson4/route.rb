class Route
  include InstanceCounter

  attr_reader :stations, :id

  ROUTE_ID_FORMAT = /^[0-9A-Z]/i

  @@routes = {}

  def initialize(id, departure_point, destination_point)
    @id = id
    validation!
    @stations = [departure_point, destination_point]
    register_instance
    @@routes[id] = self
  end

  def self.all
    @@routes
  end

  def add(station)
    @stations.insert(-2, station)
  end

  def remove(station)
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

  def involve?(station)
    stations.include?(station)
  end

  def self.find(id)
    @@routes[id]
  end

  def valid?
      validation!
    rescue
      false
  end

  private

  def validation!
    raise "Incorrect ID" if id !~ ROUTE_ID_FORMAT
    true
  end
end
