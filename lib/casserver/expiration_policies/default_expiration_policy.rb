require 'casserver/expiration_policies/abstract_expiration_policy'

# @see AbstractExpirationPolicy
# Implements the original expiration policy logic based on the scopes
# from the Model::Consumable module.
#
# @author Tyler Pickett <tyler@therapylog.com>
# @since ?
module CASServer
  module ExpirationPolicies
    class DefaultExpirationPolicy < AbstractExpirationPolicy

      # Actually implement the logic for indicating a ticket as expired. 
      # This policy is likely to be the most strict policy. Its
      # implementation is virtually the identical to the JA-SIG
      # implementation found in 
      # org.jasig.cas.ticket.support.HardTimeoutExpirationPolicy
      def ticket_expired?(ticket)
        ticket.created_on < maximum_session_lifetime.seconds.ago
      end
    end
  end
end
