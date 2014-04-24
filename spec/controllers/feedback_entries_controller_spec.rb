require 'spec_helper'

describe FeedbackEntriesController do
  describe '#create' do
    let(:params_feedback){
      { feedback_entry: { text: "amazing!" } }
    }

    it 'creates the new feedback entry' do
      expect{
        post :create, params_feedback
      }.to change(FeedbackEntry, :count).by(1)
      FeedbackEntry.last.text.should == 'amazing!'
    end

    it 'returns http status 201' do
      post :create, params_feedback
      response.status.should == 201
    end

    it 'will reference potential if valid confirmation_token given' do
      token = 'example-confirmation-token'
      potential = Fabricate(:potential)
      potential.confirmation_token = token
      potential.save!

      params_feedback_with_token = params_feedback.dup
      params_feedback_with_token[:feedback_entry][:confirmation_token] = token

      expect{
        post :create, params_feedback_with_token
      }.to change(FeedbackEntry, :count).by(1)
      FeedbackEntry.last.by.should == potential
    end

    it 'sends an email to contact@palava.tv' do
      post :create, params_feedback
      ActionMailer::Base.deliveries.last.to.should == ['contact@palava.tv']
    end

    it 'renders new json model' do
      post :create, params_feedback
      response.body.should == { feedback_entry: { text: FeedbackEntry.last.text } }.to_json
    end
  end
end
