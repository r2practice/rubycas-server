require 'spec_helper'

require 'casserver/expiration_policies/abstract_expiration_policy'
require 'casserver/model'

describe CASServer::ExpirationPolicies::AbstractExpirationPolicy do

  let(:subject){ CASServer::ExpirationPolicies::AbstractExpirationPolicy.new(300) }

  describe '.new' do
    before do
      @policy = CASServer::ExpirationPolicies::AbstractExpirationPolicy
    end

    it "should return the same instance when the same timeout is specified" do
      # compares using object_id so we know we get the same one repeatedly
      @policy.new(300).should be @policy.new(300)
    end

    it "should return different instances when different timeouts are specified" do
      @policy.new(300).should_not be @policy.new(600)
    end
  end

  describe '#ticket_expired?(ticket)' do
    it 'should raise an error since this is the abstract class' do
      expect {
        ticket = double(CASServer::Model::Ticket)
        subject.ticket_expired?(ticket)
      }.to raise_error(RuntimeError)
    end
  end
end
