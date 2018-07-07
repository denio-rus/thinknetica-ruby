class PassengerWagon < Wagon

  def load_item(volume = 1)
    volume = 1 # может это излишне, но в задании сказано точно "по одному""
    super
  end

  def type
    "passenger"
  end
end
