class CargoTrain < Train
  @instances = 0

  def type
    "cargo"
  end

  def wagon_add(wagon)
    if wagon.instance_of?(CargoWagon)
      super
    else
      "type"
    end
  end
end
