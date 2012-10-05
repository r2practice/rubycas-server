require 'casserver/expiration_policies/abstract_expiration_policy'

module CASServer
  module ExpirationPolicies
    class DefaultExpirationPolicy < AbstractExpirationPolicy
      class << self
        def ticket_expired?(ticket)
          ticket.created_on < maximum_session_lifetime.seconds.ago
        end
      end
    end
  end
end
