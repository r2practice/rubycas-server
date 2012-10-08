require 'casserver/expiration_policies/abstract_expiration_policy'

module CASServer::ExpirationPolicies
  class TimeoutExpirationPolicy < AbstractExpirationPolicy
    def ticket_expired?(ticket)
      ticket.last_activity < maximum_ticket_lifetime.seconds.ago
    end
  end
end
