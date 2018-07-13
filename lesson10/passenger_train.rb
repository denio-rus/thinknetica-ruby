class PassengerTrain < Train
  validate :id, :presense
  validate :id, :format, TRAIN_ID_FORMAT
  validate :id, :uniqueness

  def type
    'passenger'
  end

  def wagon_add(wagon)
    validate_type(wagon, PassengerWagon)
    super
  end
end
