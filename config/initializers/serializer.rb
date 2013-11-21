# module SerializerOverride
#   def to_json options = {}
#     active_model_serializer.new(self).to_json options
#   end

#   def as_json options={}
#     active_model_serializer.new(self).as_json options
#   end
# end

# Mongoid::Document.send(:include, SerializerOverride)