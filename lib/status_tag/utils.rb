module StatusTag
  module Utils

    MOD_SEPARATOR = "::"

    def class_from_string(str)
      str.split(MOD_SEPARATOR).inject(Object) do |mod, class_name|
        mod.const_get(class_name)
      end
    rescue
      nil
    end

    def namespaces_from_class(klass)
      klass.to_s.split(MOD_SEPARATOR)
    end

    def camelize_underscored(str)
      str.split('_').map {|w| w.capitalize}.join
    end

  end
end
