# encoding: utf-8

require 'spec_helper'
require_relative 'spec_features_helper'


describe 'palava | homepage', :js  do
  before(:all) { setup_client }

  before do
    visit '/?supported=1'
  end

  it 'shows the conference input field' do
    page.should have_css '#room_id'
  end

  it 'creats a new private conference on button Private' do
    click_button 'Private'
    check_location page, Rgx::UUID
    page.should have_css '#conference'
  end

  it 'creats a new private conference on buton Go if room name empty' do
    fill_in 'Conference Name', with: ''
    click_button '▸'
    check_location page, Rgx::UUID
    page.should have_css '#conference'
  end

  it 'creates a new named conference on button Go if room name not empty' do
    fill_in 'Conference Name', with: 'test'
    click_button '▸'
    check_location page, 'test'
    page.should have_css '#conference'
  end

  it 'does not create new conference info on button Go with conference name info' do
    fill_in 'Conference Name', with: 'info'
    click_button '▸'
    check_location page, 'info/how'
  end
end