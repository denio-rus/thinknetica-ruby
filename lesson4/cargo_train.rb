class CargoTrain < Train
  def type
    "cargo"
  end

  def wagon_add(wagon)
    if wagon.instance_of?(CargoWagon)
      super
    else
      Message.wagon_operation_cancel("type")
    end
  end
end
