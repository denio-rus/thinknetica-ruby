class CargoTrain < Train
  def type
    'cargo'
  end

  def wagon_add(wagon)
    raise 'Тип вагона не соответствует типу поезда.' unless wagon.instance_of?(CargoWagon)
    super
  end
end
