require 'spec_helper'

require 'casserver/expiration_policies/abstract_expiration_policy'

describe CASServer::ExpirationPolicies::AbstractExpirationPolicy do

  context "setting the maximum_session_lifetime" do
    before(:all) do
      @policy = CASServer::ExpirationPolicies::AbstractExpirationPolicy
      @max_lifetime = rand(1000000)
      @policy.maximum_session_lifetime = @max_lifetime
    end

    it "should store the maximum_session lifetime at the class level" do
      @policy.maximum_session_lifetime.should == @max_lifetime
    end

    it "should only be easy to set once" do
      @policy.should_not respond_to :maximum_session_lifetime=
    end
  end
end
