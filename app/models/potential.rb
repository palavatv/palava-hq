require 'securerandom'

class Potential
  include Mongoid::Document
  include Mongoid::Timestamps::Short


  field :email, type: String
  field :confirmed, type: Boolean
  field :confirmation_token, type: String
  field :unsubscribe_token, type: String


  has_one :feedback_entry


  validates_presence_of :email,
    message: "You must enter an email address!"
  validates_uniqueness_of :email,
    message: "", # will be ignored by client
    case_sensitive: false
  validates_format_of :email,
    message: "Not an email, please check!",
    with: /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,9}\z/i,
    allow_blank: true
  validates_presence_of :confirmation_token, on: :update
  validates_presence_of :unsubscribe_token,  on: :update


  scope :confirmed, where(confirmed: true)


  before_create :generate_confirmation_token, :generate_unsubscribe_token
  before_destroy :create_unsubscribed_potential


  def generate_unsubscribe_token
    self.unsubscribe_token = SecureRandom.uuid
  end

  def generate_confirmation_token
    self.confirmation_token = SecureRandom.uuid
  end

  def create_unsubscribed_potential
    UnsubscribedPotential.create_from_potential!(self)
  end


  def active_model_serializer
    PotentialSerializer
  end
end
