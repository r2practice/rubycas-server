require 'spec_helper'

require 'casserver/expiration_policies/default_expiration_policy'
require 'casserver/model'

describe CASServer::ExpirationPolicies::DefaultExpirationPolicy do
  before do
    @policy = CASServer::ExpirationPolicies::DefaultExpirationPolicy
    @policy.instance_variable_set(:@maximum_session_lifetime, 30)
  end

  describe '.ticket_expired?(ticket)' do
    context "when the ticket's created_on attribute is older than maximum lifetime" do
      before do
        @time = (@policy.maximum_session_lifetime + 1).seconds.ago
        @tgt = double(CASServer::Model::TicketGrantingTicket)
        @tgt.stub({
          :created_on => @time
        })
      end

      it "should return true" do
        @policy.ticket_expired?(@tgt).should be true
      end
    end

    context "when the ticket's created_on attribute is newer than the maximum lifetime" do
      before do
        @time = (@policy.maximum_session_lifetime - 1).seconds.ago
        @tgt = double(CASServer::Model::TicketGrantingTicket)
        @tgt.stub({
          :created_on => @time
        })
      end

      it "should return false" do
        @policy.ticket_expired?(@tgt).should be false
      end
    end

    context "when the ticket's created_on attribute is exactly the maximum lifetime" do
      before do
        @time = (@policy.maximum_session_lifetime).seconds.ago
        @tgt = double(CASServer::Model::TicketGrantingTicket)
        @tgt.stub({
          :created_on => @time
        })
      end

      it "should return true" do
        @policy.ticket_expired?(@tgt).should be true
      end
    end
  end
end
