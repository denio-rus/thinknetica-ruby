class Wagon
  include Production

  attr_reader :id, :status

  @@wagons = []

  def initialize(id)
    @id = id
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
end
