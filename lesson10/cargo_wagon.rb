class CargoWagon < Wagon
  validate :id, :presense
  validate :id, :format, WAGON_ID_FORMAT
  validate :id, :uniqueness
  validate :capacity, :type, Numeric

  def wagon_type
    'cargo'
  end
end
