module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
    base.send :instances=, 0
  end

  module ClassMethods
    attr_reader :instances

    def instances_increment
      @instances += 1
    end

    private
    attr_writer :instances
  end

  module InstanceMethods
    private
    def register_instance
     self.class.instances_increment
    end
  end
end
