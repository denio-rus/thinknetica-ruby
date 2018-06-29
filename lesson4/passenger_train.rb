class PassengerTrain < Train
  @instances = 0

  def type
    "passenger"
  end

  def wagon_add(wagon)
    if wagon.instance_of?(PassengerWagon)
      super
    else
      "type"
    end
  end
end
