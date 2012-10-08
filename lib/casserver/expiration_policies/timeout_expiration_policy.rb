require 'casserver/expiration_policies/abstract_expiration_policy'

# @see AbstractExpirationPolicy
# Implement expiration policy based on ticket activity (use)
# rather than creation time
#
# @author Tyler Pickett <tyler@therapylog.com>
# @since ?
module CASServer::ExpirationPolicies
  class TimeoutExpirationPolicy < AbstractExpirationPolicy
    def ticket_expired?(ticket)
      ticket.last_activity < maximum_ticket_lifetime.seconds.ago
    end
  end
end
