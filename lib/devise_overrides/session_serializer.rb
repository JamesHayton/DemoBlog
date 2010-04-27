module DeviseOverrides::SessionSerializer
  class Warden::SessionSerializer
    def serialize(record)
      [record.class, record.id]
    end

    def deserialize(keys)
      klass, id = keys
      klass.by__id(:key => id).first
    end
  end
end
