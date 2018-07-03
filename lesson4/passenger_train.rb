class PassengerTrain < Train

  def type
    "passenger"
  end

  def wagon_add(wagon)
    if wagon.instance_of?(PassengerWagon)
      super
    else
      raise "Тип вагона не соответствуют типу поезда."
    end
  end
end
