class Wagon
  include Production
  include ValidationMethods

  WAGON_ID_FORMAT = /^[0-9A-Z]/i

  attr_reader :id, :status, :capacity, :capacity_in_use

  def self.find(id)
    @@wagons.find { |wagon| wagon.id == id }
  end

  @@wagons = []

  def initialize(id, capacity)
    @id = id
    @capacity = capacity
    @capacity_in_use = 0
    validate!
    @status = 'free'
    @@wagons << self
  end

  def set_free
    @status = 'free'
  end

  def set_in_use
    @status = 'in use'
  end

  def free_capacity
    capacity - capacity_in_use
  end

  def load_item(volume)
    raise 'Argument type error' unless volume.is_a? Numeric
    raise 'Задан отрицательный объем' if volume < 0
    raise 'Превышена вместимость вагона' if capacity_in_use + volume > capacity
    @capacity_in_use += volume
  end

  protected

  def validate!
    raise 'Argument type error' unless @capacity.is_a? Numeric
    raise 'Указана некорректная грузоподъемность' if @capacity <= 0
    raise 'Incorrect ID' if @id !~ WAGON_ID_FORMAT
    validate_uniqueness_of(@id)
  end
end
