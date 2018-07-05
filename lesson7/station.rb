class Station
  include InstanceCounter
  include ValidationMethods

  attr_reader :trains, :name

  # в моем понимании это выражение подразумевает, что название должно начинаться с цифры или большой буквы
  # и состоять как минимум из 2 символов. Нашел реальные станции, называющиеся "120 км" или "31 км ЗСИ". Как их подогнать в регулярное?
  NAME_FORMAT = /^[0-9A-Z]{1}[0-9a-z]{1,}/

  @@stations = {}

  def initialize(name)
    @name = name
    validate!
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
    validate_train(train)
    @trains << train
  end

  def train_departure(train)
    validate_train(train)
    @trains.delete(train)
  end

  private

  def validate!
    raise "Blank input" if @name == nil
    raise "Argument type error" unless @name.instance_of? String
    raise "Недопустимое имя." if @name !~ NAME_FORMAT
    validate_uniqueness_of(@name)
  end
end
