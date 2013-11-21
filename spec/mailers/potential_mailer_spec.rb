require "spec_helper"

describe PotentialMailer do
  let(:potential){ Fabricate(:potential) }


  describe 'welcome' do
    let(:mail) { PotentialMailer.welcome(potential) }

    it 'renders the subject' do
      mail.subject.should =~ /thank you/i
    end

    it 'renders the receiver email' do
      mail.to.should == [potential.email]
    end

    it 'should contain confirmation url' do
      mail.body.encoded.should =~ %r[https://palava.tv/plv/confirm/#{Rgx::UUID}]
    end

    it 'should contain business footer' do
      mail.body.encoded.should =~ /VR 5967/
    end
  end
end
