module Accessors
  def attr_accessors_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      history_var_name = "@#{name}_history".to_sym
      define_method("#{name}_history") { instance_variable_get(history_var_name) }
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(history_var_name, []) unless instance_variable_get(history_var_name)
        instance_variable_set(history_var_name, instance_variable_get(history_var_name) << instance_variable_get(var_name))
        instance_variable_set(var_name, value)
      end
    end
  end

  def strong_attr_accessor(name, klass)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      raise 'Type error' unless value.kind_of?(klass)
      instance_variable_set(var_name, value)
    end
  end
end
