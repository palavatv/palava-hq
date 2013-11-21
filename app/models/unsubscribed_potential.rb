class UnsubscribedPotential
  include Mongoid::Document
  # FAKE TIMESTAMPS


  field :confirmed, type: Boolean
  field :c_at, type: Time, as: :created_at
  field :u_at, type: Time, as: :updated_at


  attr_readonly *fields.keys
  attr_accessible *fields.keys


  def self.create_from_potential!(potential)
    raise ArgumentError unless potential.is_a? Potential
    create! potential.attributes.slice *%w[_id confirmed c_at u_at]
  end
end