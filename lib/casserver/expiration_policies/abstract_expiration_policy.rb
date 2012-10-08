require 'active_support'

# @abstract Subclass and override #{ticket_expired?} to implement
#   an ExpirationPolicy
#
# @author Tyler Pickett <tyler@therapylog.com>
# @since ?
module CASServer
  module ExpirationPolicies
    class AbstractExpirationPolicy

      # Entry point for determining if a ticket is expired
      # This will enable our Tickets to delegate their
      # expiration behavior to the various subclasses of this one
      #
      # @example Implement Ticket#expired?
      # def expired?
      #   expiration_policy.constantize.ticket_expired?(self)
      # end
      def ticket_expired?(ticket)
        raise "ticket_expired? not implemented in AbstractExpirationPolicy, please override in #{self.name}"
      end
    end
  end
end
