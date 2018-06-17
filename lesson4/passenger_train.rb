class PassengerTrain < Train

  def wagon_add(wagon)
    if wagon.instance_of?(PassengerWagon)
      super
    else
      puts "Тип вагона не соответствует типу поезда."
    end
  end
end
