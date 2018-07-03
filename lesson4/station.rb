class Station
  include InstanceCounter

  attr_reader :trains, :name

  NAME_FORMAT = /^[0-9A-Z]/

  @@stations = {}

  def initialize(name)
    @name = name
    validation!
    @trains = []
    @@stations[name] = self
    register_instance
  end

  def self.all
    @@stations
  end

  def self.find(name)
    @@stations[name]
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

  def valid?
      validation!
    rescue
      false
  end

  private

  def validation!
    raise "Недопустимое имя." if @name !~ NAME_FORMAT
    true
  end
end
