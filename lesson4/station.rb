class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def trains_by_type(type)
    @trains.count { |train| train.instance_of?(CargoTrain) } if type == "cargo"
    @trains.count { |train| train.instance_of?(CargoTrain) } if type == "passenger"
  end

  def train_arrive(train)
    @trains << train
  end

  def train_departure(train)
    @trains.delete(train)
  end
end
