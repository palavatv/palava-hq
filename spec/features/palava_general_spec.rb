require 'spec_helper'
require_relative 'spec_features_helper'


describe 'palava | general', :js  do
  before(:all) { setup_client }

  describe 'general' do
    it 'redirects any unknown path to angular' do
      visit '/some_path?supported=1'
      check_location page, 'some_path'
    end

    it 'shows not-supported message when no compatible browser detected' do
      visit '/#/?supported=0'
      page.should have_css('.nosupport')
    end

    it 'shows a message when javascript is not activated', js: false do
      visit '/'
      page.should have_css('.noscript-hint')
    end
  end

  describe 'footer' do
    ["", *%w(
      info/how
      info/feedback
      info/contact
      info/error
      test_room
    )].each { |sub_page|
      context "[#{sub_page}]" do
        before do
          visit "/#/#{sub_page}?supported=1"
        end

        it 'visits the howitworks page on link How to Use' do
          click_link 'How to Use'
          check_location page, "info/how"
          page.should have_css '#how-it-works'
          page.should have_content "WebRTC"
        end

        it 'visits the ev page on link palava e. V.' do
          click_link 'palava e. V.'
          check_location page, "info/ev"
          page.should have_css '#ev'
          page.should have_content "e. V."
        end

        it 'visits the contact page on link Imprint' do
          click_link 'Imprint'
          check_location page, "info/contact"
          page.should have_css '#contact'
          page.should have_content "Imprint"
        end
      end
    }
  end
end
