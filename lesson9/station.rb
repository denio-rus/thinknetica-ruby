class Station
  include InstanceCounter
  include ValidationMethods

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
    validate!
    @trains = []
    @@stations[name] = self
    register_instance
  end

  def trains_by_type(type)
    @trains.count { |train| train.type == type }
  end

  def train_arrive(train)
    validate_object(train, Train)
    @trains << train
  end

  def train_departure(train)
    validate_train(train)
    @trains.delete(train)
  end

  def each_train
    @trains.each do |train|
      yield(train) if block_given?
    end
  end

  private

  def validate!
    raise 'Argument type error' unless @name.instance_of? String
    raise 'Недопустимое имя.' if @name !~ NAME_FORMAT
    validate_uniqueness_of(@name)
  end
end
