ActionController::API.send :include, ActionController::StrongParameters

module Mongoid
  module Document
    include ActiveModel::ForbiddenAttributesProtection
  end
end