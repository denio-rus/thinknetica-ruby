class PassengerWagon < Wagon
  validate :id, :presense
  validate :id, :format, WAGON_ID_FORMAT
  validate :id, :uniqueness
  validate :capacity, :type, Numeric

  def load_item
    super(1)
  end

  def wagon_type
    'passenger'
  end
end
