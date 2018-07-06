class PassengerWagon < Wagon
  attr_reader :seats, :taken_seats

  def initialize(id, seats)
    @seats = seats
    @taken_seats = 0
    super(id)
  end

  def type
    "passenger"
  end

  def take_passenger
    if taken_seats < seats
      @taken_seats += 1
    else
      raise "В вагоне нет свободных мест"
    end
  end

  def free_seats
    seats - taken_seats
  end

  private

  def validate!
    raise "Argument type error" unless @seats.is_a? Integer
    raise "Указано некорректное количество мест" if @seats <= 0
    super
  end
end
