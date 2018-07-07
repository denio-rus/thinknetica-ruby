class PassengerWagon < Wagon

  def load_item
    raise "Превышена вместимость вагона" if capacity_in_use == capacity
    @capacity_in_use += 1
  end

  def type
    "passenger"
  end
end
