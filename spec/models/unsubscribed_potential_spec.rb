# encoding: utf-8

require 'spec_helper'

describe UnsubscribedPotential do
  let(:potential) {
    Fabricate :confirmed_potential do
      c_at Date.yesterday
      u_at Date.today
    end
  }

  it 'is readonly' do
    up = UnsubscribedPotential.create!(
      _id: "eiuaendtiurentdulginetiudlrtunedir",
      confirmed: true,
      c_at: Date.yesterday,
      u_at: Date.today,
    )

    up.update_attributes!(u_at: Time.now, confirmed: false)

    up.u_at.should == Date.today
    up.confirmed.should == true
  end

  describe '.create_from_potential!' do
    it 'calls .create!' do
      mock(UnsubscribedPotential).create!(anything).once
      UnsubscribedPotential.create_from_potential!(potential)
    end

    it 'creates a record with the same id, confirmed, c_at and u_at fields' do
      up = UnsubscribedPotential.create_from_potential!(potential)

      up.id.should        == potential.id
      up.confirmed.should == potential.confirmed
      up.c_at.should      == potential.c_at
      up.u_at.should      == potential.u_at
      up.should_not respond_to :email
    end

    it 'does not work if given argument is not a potential' do
      expect {
        UnsubscribedPotential.create_from_potential! nil
      }.to raise_exception(ArgumentError)
    end
  end
end
