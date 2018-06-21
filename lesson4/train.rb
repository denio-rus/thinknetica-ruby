class Train
  attr_reader :speed, :id, :type, :wagons

  def initialize(id)
    @id = id
    @wagons = []
    @speed = 0
  end

  def decrease_speed(value)
    @speed -= value
    @speed = 0 if speed < 0
  end

  def increase_speed(value)
    @speed += value
  end

  def wagon_add(wagon)
    if speed == 0
      @wagons << wagon
      wagon.set_in_use
    else
      Message.wagon_operation_cancel("moving")
    end
  end

  def wagon_remove(wagon)
    if speed == 0 && @wagons.include?(wagon)
      @wagons.delete(wagon)
      wagon.set_free
    elsif speed != 0
      Message.wagon_operation_cancel("moving")
    else
      Message.wagon_operation_cancel("absence")
    end
  end

  def take_route(route)
    @route = route
    @current_station_index = 0
    @route.stations.first.train_arrive(self)
  end

  def move_next
    until @route
      Message.route_operation_cancel("absence")
      return
    end

    if next_station
      current_station.train_departure(self)
      next_station.train_arrive(self)
      @current_station_index += 1
    else
      Message.route_operation_cancel("destination")
    end
  end

  def move_back
    until @route
      Message.route_operation_cancel("absence")
      return
    end

    if previous_station
      current_station.train_departure(self)
      previous_station.train_arrive(self)
      @current_station_index -= 1
    else
      Message.route_operation_cancel("departure")
    end
  end

  def current_station
    @route.stations[@current_station_index]
  end

  def next_station
    @route.stations[@current_station_index + 1] if @current_station_index != @route.stations.size - 1
  end

  def previous_station
    @route.stations[@current_station_index - 1] if @current_station_index != 0
  end
end
