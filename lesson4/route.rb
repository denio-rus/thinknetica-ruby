class Route
  attr_reader :stations, :id

  def initialize(id, departure_point, destination_point)
    @id = id
    @stations = [departure_point, destination_point]
  end

  def add(station)
    @stations.insert(-2, station)
  end

  def remove(station)
    if [departure, destination].include?(station)
      "can't delete"
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
end
