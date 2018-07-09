module ValidationMethods
  WRONG_OBJECT_MESSAGE = 'Передан объект неподходящего класса'.freeze

  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  def validate_object(object, klass)
    raise WRONG_OBJECT_MESSAGE unless object.is_a?(klass)
  end

  def validate_uniqueness_of(attribute)
    existent_object = self.class.find(attribute)
    raise "Атрибут #{attribute} уже использован" if existent_object && existent_object != self
  end
end
