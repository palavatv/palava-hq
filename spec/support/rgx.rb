module Rgx
  UUID = /\w{8}-\w{4}-\w{4}-\w{4}-\w{12}/

  class << self
    def az
      Module.new do
        def self.const_missing(which)
          /\A#{Rgx.const_get(which)}\z/
        end
      end
    end
  end
end