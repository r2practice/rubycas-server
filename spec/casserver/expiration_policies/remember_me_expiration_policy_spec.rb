require 'spec_helper'

require 'casserver/expiration_policies/remember_me_expiration_policy'

require 'casserver/expiration_policies/timeout_expiration_policy'
require 'casserver/model'

describe CASServer::ExpirationPolicies::RememberMeExpirationPolicy do

  describe "#ticket_expired?" do
    before do
      @tgt = double(CASServer::Model::TicketGrantingTicket)
      @standard_policy = double(CASServer::ExpirationPolicies::TimeoutExpirationPolicy)
      @standard_policy.stub(:ticket_expired? => 'standard')
      @remember_policy = double(CASServer::ExpirationPolicies::TimeoutExpirationPolicy)
      @remember_policy.stub(:ticket_expired? => 'long')
      @subject = CASServer::ExpirationPolicies::RememberMeExpirationPolicy.new(@standard_policy, @remember_policy)
    end

    it "should delegate to the standard policy if the ticket reports a falsey remember_me in extra_attributes" do
      @tgt.stub(:extra_attributes => {})
      @subject.ticket_expired?(@tgt).should == 'standard'
    end

    it "should delegate to the remember policy if the ticket reports a truthy remember_me in extra_attributes" do
      @tgt.stub(:extra_attributes => { :remember_me => true })
      @subject.ticket_expired?(@tgt).should == 'long'
    end
  end
end
