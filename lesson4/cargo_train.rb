class CargoTrain < Train

  def initialize(id)
    @type = "cargo"
    super
  end

  def wagon_add(wagon)
    if wagon.instance_of?(CargoWagon)
      super
    else
      puts "Тип вагона не соответствует типу поезда."
    end
  end
end
