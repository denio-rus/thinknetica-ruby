class PassengerTrain < Train
  def type
    'passenger'
  end

  def wagon_add(wagon)
    raise 'Тип вагона не соответствуют типу поезда.' unless wagon.instance_of?(PassengerWagon)
    super
  end
end
