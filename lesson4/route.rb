class Route
  attr_reader :stations

  def initialize(departure_point, destination_point)
    @stations = [departure_point, destination_point]
  end

  def add(station)
    @stations.insert(-2, station)
  end

  def remove(station)
    if [departure, destination].include?(station)
      puts "Эту станцию нельзя удалить из маршрута"
    else
      @stations.delete(station)
    end
  end

  def list_stations
    @stations.each { |station| puts station.name }
  end

  private
# эти методы используются только внутри объекта, то есть не являются интерфейсом.
    def departure
    @stations.first
  end

  def destination
    @stations.last
  end
end
