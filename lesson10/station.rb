class Station
  include InstanceCounter
  include Validation

  NAME_FORMAT = /^[0-9A-Z]{1}[0-9a-z]{1,}/

  attr_reader :trains, :name

  @@stations = {}

  def self.all
    @@stations
  end

  def self.find(name)
    @@stations[name]
  end

  def initialize(name)
    @name = name
    validate! do
      self.class.validate(@name, :presense)
      self.class.validate(@name, :format, NAME_FORMAT)
      validate_uniqueness_of(@name)
    end
    @trains = []
    @@stations[name] = self
    register_instance
  end

  def trains_by_type(type)
    @trains.count { |train| train.type == type }
  end

  def train_arrive(train)
    self.class.validate(train, :type, Train)
    @trains << train
  end

  def train_departure(train)
    @trains.delete(train)
  end

  def each_train
    @trains.each do |train|
      yield(train) if block_given?
    end
  end
end
