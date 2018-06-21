class PassengerTrain < Train
  def type
    "passenger"
  end

  def wagon_add(wagon)
    if wagon.instance_of?(PassengerWagon)
      super
    else
      Message.wagon_operation_cancel("type")
    end
  end
end
