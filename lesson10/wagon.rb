class Wagon
  include Production
  include Validation
  extend Accessors

  WAGON_ID_FORMAT = /^[0-9A-Z]/i

  attr_reader :id, :status, :capacity, :capacity_in_use

  @@wagons = []

  validate :id, :presense
  validate :id, :format, WAGON_ID_FORMAT
  validate :id, :uniqueness
  validate :capacity, :type, Numeric

  def self.find(id)
    @@wagons.find { |wagon| wagon.id == id }
  end



  def initialize(id, capacity)
    @id = id
    @capacity = capacity
    @capacity_in_use = 0
    validate!
    raise 'Указана некорректная грузоподъемность' if @capacity <= 0
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
    raise 'Задан отрицательный объем' if volume < 0
    raise 'Превышена вместимость вагона' if capacity_in_use + volume > capacity
    self.capacity_in_use += volume
  end
  protected
  strong_attr_writer :capacity_in_use, Numeric
end
