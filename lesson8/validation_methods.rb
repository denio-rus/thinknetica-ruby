module ValidationMethods

  WRONG_OBJECT_MESSAGE = "Передан объект неподходящего класса"

  def valid?
    validate!
    true
  rescue
    false
  end

  def validate_object(object, expected_class)
    raise  WRONG_OBJECT_MESSAGE unless object.instance_of?(expected_class)
  end

  def validate_train(object)
    raise WRONG_OBJECT_MESSAGE unless object.is_a? Train
  end

  def validate_uniqueness_of (attribute)
    existent_object = self.class.find(attribute)
    raise "Атрибут #{attribute} уже использован" if existent_object && existent_object != self
  end
end
