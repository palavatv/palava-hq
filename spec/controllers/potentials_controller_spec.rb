require 'spec_helper'

describe PotentialsController do
  describe '#create' do
    context 'valid' do
      let(:params_true){ { potential: Fabricate.attributes_for(:potential) } }

      it 'creates the new potential' do
        expect{
          post :create, params_true
        }.to change(Potential, :count).by(1)
        Potential.last.email.should == 'someone@palava.tv'
      end

      it 'returns http status 201' do
        post :create, params_true
        response.status.should == 201
      end

      it 'sends out the "please confirm" email' do
        post :create, params_true
        ActionMailer::Base.deliveries.last.to.should == [Potential.last.email]
      end

      it 'renders new json model' do
        post :create, params_true
        response.body.should == { potential: { email: Potential.last.email } }.to_json
      end
    end

    context 'invalid' do
      let(:params_false){ { potential: Fabricate.attributes_for(:potential_with_invalid_email) } }

      it 'does not create the new potential' do
        expect{
          post :create, params_false
        }.to_not change(Potential, :count)
      end

      it 'returns http status false' do
        post :create, params_false
        response.status.should == 422
      end

      it 'renders error message' do
        post :create, params_false
        response.body.should == { errors: { email: ["Not an email, please check!"] } }.to_json
      end
    end

    context 'invalid - without params' do
      it 'create without params status' do
        post :create
        response.status.should == 400
      end

      it 'create without params errors' do
        post :create
        response.body.should == { errors: { missing_parameter: 'potential' } }.to_json
      end
    end
  end

  describe '#update' do
    context 'potential can be found' do
      it 'sets confirmed to true' do
        potential = Fabricate(:potential)
        expect {
          get :update, confirmation_token: potential.confirmation_token
        }.to change{potential.reload.confirmed}.from(nil).to(true)
      end
    end
  end

  describe '#destroy' do
    context 'potential can be found' do
      it 'creates a new unsubscribed potential and deletes original one' do
        potential = Fabricate(:potential)
        mock(UnsubscribedPotential).create_from_potential!(potential).once
        expect {
          get :destroy, unsubscribe_token: potential.unsubscribe_token
        }.to change(Potential, :count).by(-1)
      end
    end
  end
end