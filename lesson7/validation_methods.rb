module ValidationMethods

  WRONG_OBJECT_MESSAGE = "Передан объект неподходящего класса"
  ID_TAKEN_MESSAGE = "Идентификатор уже используется"

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

  def is_free?(id)
    raise ID_TAKEN_MESSAGE if self.class.find(id)
  end
end
