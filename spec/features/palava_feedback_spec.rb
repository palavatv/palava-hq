require 'spec_helper'
require_relative 'spec_features_helper'


describe 'palava | feedback', :js  do
  before(:all) { setup_client }

  describe 'page' do
    before do
      visit '/#/info/feedback'
    end

    it 'contains a feedback form' do
      expect(page.find '.feedback-form textarea').to be_visible
    end

    it 'shows thank you message after submitting feedback' do
      fill_in('feedback', with: 'amazing!')
      click_button 'Send'
      sleep 0.3 # ...
      expect(page.find '.feedback-thank-you').to be_visible
    end

    it 'actually sends feedback' do
      expect {
        fill_in('feedback', with: 'amazing!')
        click_button 'Send'
        sleep 0.3 # ...
      }.to change{FeedbackEntry.all.size}.by(1)
    end


    it 'does nothing when submitting an empty feedback field' do
      click_button 'Send'
      expect(page.find '.feedback-thank-you').to_not be_visible
      expect(page.find '.feedback-form textarea').to be_visible
    end
  end

  describe 'confirm' do
    context 'potential to confirm exists' do
      let(:potential){ Fabricate(:potential) }
      let(:token){ potential.confirmation_token }

      before do
        visit update_potential_path(token)
      end

      it 'displays feedback page with "thank for confirmation" section enabled' do
        check_location page, 'info/feedback'
        expect(page.find '.confirmed-thank-you').to be_visible
      end

      it 'associates sent feedback with this potential' do
        expect {
          expect {
            fill_in('feedback', with: 'amazing!')
            click_button 'Send'
            sleep 0.3 # ...
          }.to change{ FeedbackEntry.last && FeedbackEntry.last.text }.to('amazing!')
        }.to change{ FeedbackEntry.last && FeedbackEntry.last.by }.to(potential)
      end
    end

    context 'potential to confirm does not exist' do
      before do
        visit update_potential_path("something-invalid")
      end

      it 'displays error page with explainations' do
        check_location page, 'info/error?code=wrong_confirmation_token'
      end
    end
  end

  describe 'unsubscribe' do
    context 'potential to destroy exists' do
      let(:potential){ Fabricate(:potential) }
      let(:token){ potential.unsubscribe_token }

      before do
        visit destroy_potential_path(token)
      end

      it 'displays feedback page with "we regret seeing you go" section enabled' do
        check_location page, 'info/feedback'
        expect(page.find '.unsubscribed-thank-you').to be_visible
      end
    end

    context 'potential to desroy does not exist' do
      before do
        visit destroy_potential_path("something-invalid")
      end

      it 'displays error page with explainations' do
        check_location page, 'info/error?code=noone_to_unsubscribe'
      end
    end
  end
end