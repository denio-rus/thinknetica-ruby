class Wagon
  attr_reader :type, :id
  attr_accessor :status

  def initialize(id)
    @id = id
    @status = "free"
  end

end
