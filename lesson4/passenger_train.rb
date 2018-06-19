class PassengerTrain < Train

  def initialize(id)
    @type = "passenger"
    super
  end

  def wagon_add(wagon)
    if wagon.instance_of?(PassengerWagon)
      super
    else
      puts "Тип вагона не соответствует типу поезда."
    end
  end
end
