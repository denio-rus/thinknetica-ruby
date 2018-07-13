module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(attribute, validation_type, optional = 'none')
      case validation_type
      when :presense
        raise "#{attribute} doesn't present" if attribute.nil? && attribute.empty?
      when :format
        raise "#{attribute} doesn't match format #{optional}" if attribute.to_s !~ optional
      when :type
        raise "#{attribute} is not #{optional}" unless attribute.is_a?(optional)
      end
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue RuntimeError
      false
    end

    def validate_uniqueness_of(attribute)
      existent_object = self.class.find(attribute)
      raise "Атрибут #{attribute} уже использован" if existent_object && existent_object != self
    end

    private

    def validate!
      yield if block_given?
    rescue RuntimeError => e
      puts e.message
      raise
    end
  end
end
