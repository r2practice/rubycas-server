require 'spec_helper'

require 'casserver/expiration_policies/timeout_expiration_policy'
require 'casserver/model'

describe CASServer::ExpirationPolicies::TimeoutExpirationPolicy do
  let(:subject){ CASServer::ExpirationPolicies::TimeoutExpirationPolicy.new(300) }

  describe '#ticket_expired?(ticket)' do
    before do
      @tgt = double(CASServer::Model::TicketGrantingTicket)
    end

    it "should return true when ticket#last_activity is older than the timeout" do
      @tgt.stub(:last_activity => 301.seconds.ago)
      subject.ticket_expired?(@tgt).should be true
    end

    it "should return true when ticket#last_activity is exactly at the timeout" do
      @tgt.stub(:last_activity => 300.seconds.ago)
      subject.ticket_expired?(@tgt).should be true
    end

    it "should return false when ticket#last_activity is newer than the timeout" do
      @tgt.stub(:last_activity => 299.seconds.ago)
      subject.ticket_expired?(@tgt).should be false
    end
  end
end
