class CargoTrain < Train
  validate :id, :presense
  validate :id, :format, TRAIN_ID_FORMAT
  validate :id, :uniqueness

  def type
    'cargo'
  end

  def wagon_add(wagon)
    validate_type(wagon, CargoWagon)
    super
  end
end
