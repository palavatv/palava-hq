class FeedbackEntry
  include Mongoid::Document
  include Mongoid::Timestamps::Short


  field :text, type: String


  belongs_to :by, class_name: 'Potential'


  validates_presence_of :text,
    message: "Please give us your opinion!"


  def confirmation_token=(token)
    self.by = Potential.find_by(confirmation_token: token)
  rescue Mongoid::Errors::DocumentNotFound
  end

  def active_model_serializer
    FeedbackEntrySerializer
  end
end
