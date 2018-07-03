class CargoTrain < Train

  def type
    "cargo"
  end

  def wagon_add(wagon)
    if wagon.instance_of?(CargoWagon)
      super
    else
      raise "Тип вагона не соответствуют типу поезда."
    end
  end
end
