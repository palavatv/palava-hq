require 'spec_helper'

describe FeedbackEntry do
  it { should validate_presence_of(:text) }


  describe '#create' do
    it 'will create reference to a potential if confirmation_token given' do
      p = Fabricate(:potential)
      f = FeedbackEntry.create! text: 'hey', confirmation_token: p.confirmation_token
      f.by.should == p
    end
  end
end
