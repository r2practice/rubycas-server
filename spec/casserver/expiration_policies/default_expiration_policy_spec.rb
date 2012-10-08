require 'spec_helper'

require 'casserver/expiration_policies/default_expiration_policy'
require 'casserver/model'

describe CASServer::ExpirationPolicies::DefaultExpirationPolicy do
  let(:subject) { CASServer::ExpirationPolicies::DefaultExpirationPolicy.new(300) }

  describe "#ticket_expired?(ticket)" do
    before do
      @tgt = double(CASServer::Model::TicketGrantingTicket)
    end

    it "should return true when the ticket was created more than timeout seconds ago" do
      @tgt.stub(:created_on => 301.seconds.ago)
      subject.ticket_expired?(@tgt).should be true
    end

    it "should return false when the ticket was created less than timeout seconds ago" do
      @tgt.stub(:created_on => 299.seconds.ago)
      subject.ticket_expired?(@tgt).should be false
    end

    it "should return true then the ticket was created exactly timeout seconds ago" do
      @tgt.stub(:created_on => 300.seconds.ago)
      subject.ticket_expired?(@tgt).should be true
    end
  end
end
