class Station
  include InstanceCounter
  include Validation
  extend Accessors

  NAME_FORMAT = /^[0-9A-Z]{1}[0-9a-z]{1,}/

  attr_reader :trains, :name

  @@stations = {}

  validate :name, :presense
  validate :name, :format, NAME_FORMAT
  validate :name, :uniqueness

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
    @number_of_trains = 0
    @@stations[name] = self
    register_instance
  end

  def max_number_of_trains
    self.number_of_trains += 0 # это для того, чтобы учитывался и последний поезд. Понимаю, что криво, но этот баг всплыл уже на тестировании ))
    number_of_trains_history.max
  end


  def trains_by_type(type)
    @trains.count { |train| train.type == type }
  end

  def train_arrive(train)
    validate_type(train, Train)
    @trains << train
    self.number_of_trains += 1
  end

  def train_departure(train)
    @trains.delete(train)
    self.number_of_trains -= 1
  end

  def each_train
    @trains.each do |train|
      yield(train) if block_given?
    end
  end

  protected
  attr_accessor_with_history :number_of_trains
end
