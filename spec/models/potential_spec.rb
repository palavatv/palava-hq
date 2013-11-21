require 'spec_helper'

describe Potential do
  it { should validate_presence_of(:confirmation_token).on(:update) }
  it { should validate_presence_of(:unsubscribe_token ).on(:update) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_format_of(:email).to_allow('as12@df34.gh') }
  ['awerty', 'jsfcjas.de', '@dasdq.hy', 'kahdkasd.63'].each{ |femail|
    it { should validate_format_of(:email).not_to_allow(femail) }
  }


  describe '#create' do
    let(:potential){ Fabricate(:potential) }

    it 'creates a new uuid for confirmation_token' do
      potential.confirmation_token.should =~ Rgx.az::UUID
    end

    it 'creates a new uuid for unsubscribe_token' do
      potential.confirmation_token.should =~ Rgx.az::UUID
    end

    it 'is not confirmed, yet' do
      potential.confirmed.should_not be_true
    end
  end

  describe '#destroy' do
    let(:potential){ Fabricate(:confirmed_potential) }

    it 'creates a new UnsubscribedPotential with the same values for id, confirmed, c_at, u_at' do
      potential_attributes = potential.attributes
      sleep 2 # test c_at more reliable
      expect {
        expect {
          potential.destroy
        }.to change{Potential.all.count}.by(-1)
      }.to change{UnsubscribedPotential.all.count}.by(1)

      up = UnsubscribedPotential.last.attributes
      up['confirmed'].should == potential_attributes['confirmed']
      up['c_at'].to_i.should == potential_attributes['c_at'].to_i
      up['u_at'].to_i.should == potential_attributes['u_at'].to_i
      up['_id'].should       == potential_attributes['_id']
    end
  end
end
