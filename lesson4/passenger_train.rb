class PassengerTrain < Train
  include InstanceCounter

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
