class Wagon
  include Production

  attr_reader :id, :status

  @@wagons = []

  def initialize(id)
    @id = id
    validate!
    @status = "free"
    @@wagons << self
  end

  def self.find(id)
    @@wagons.find { |wagon| wagon.id == id }
  end

  def set_free
    @status = "free"
  end

  def set_in_use
    @status = "in use"
  end

  private

  def validate!
    raise "Blank input" if @id == nil
  end

end
