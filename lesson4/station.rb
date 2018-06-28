class Station
  include InstanceCounter

  attr_reader :trains, :name

  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
  end

  def self.all
    @@stations
  end

  def self.find(name)
    @@stations.find { |station| station.name == name }
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
