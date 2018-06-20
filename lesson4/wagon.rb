class Wagon
  attr_reader :id, :status

  def initialize(id)
    @id = id
    @status = "free"
  end

  def set_free
    @status = "free"
  end

  def set_in_use
    @status = "in use"
  end
end
