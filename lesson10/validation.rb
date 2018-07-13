module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(*args)
      @validations ||= []
      @validations << args
    end

    def validations
      @validations
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        method = "validate_#{validation[1]}".to_sym
        attribute = send(validation[0])
        parameter = validation[2]
        if parameter
          send(method, attribute, parameter)
        else
          send(method, attribute)
        end
      end
    end

    def valid?
      validate!
      true
    rescue RuntimeError
      false
    end

    def validate_uniqueness(attribute)
      existent_object = self.class.find(attribute)
      raise "Атрибут #{attribute} уже использован" if existent_object && existent_object != self
    end

    def validate_presense(attribute)
      raise "#{attribute} doesn't present" if attribute.nil? || attribute.empty?
    end

    def validate_format(attribute, regexp)
      raise "#{attribute} doesn't match format #{regexp}" if attribute.to_s !~ regexp
    end

    def validate_type(attribute, klass)
      raise "not #{klass}" unless attribute.is_a?(klass)
    end
  end
end
