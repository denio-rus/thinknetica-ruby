class CargoWagon < Wagon
  attr_reader :cargo_volume, :taken_volume

  def initialize(id, cargo_volume)
    @cargo_volume = cargo_volume
    @taken_volume = 0
    super(id)
  end

  def type
    "cargo"
  end

  def take_cargo(volume)
    raise "Argument type error" unless volume.instance_of? Float
    raise "Задан отрицательный объем" if volume < 0

    if taken_volume + volume < cargo_volume
      @taken_volume += volume
    else
      raise "Объем груза превышает свободную вместимость вагона"
    end
  end

  def free_volume
    cargo_volume - taken_volume
  end

  private

  def validate!
    raise "Argument type error" unless @cargo_volume.instance_of? Float
    raise "Указана некорректная грузоподъемность" if @cargo_volume <= 0
    super
  end
end
