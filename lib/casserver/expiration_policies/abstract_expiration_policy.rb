require 'active_support'

# @abstract Subclass and override #{ticket_expired?} to implement
#   an ExpirationPolicy
#
# @author Tyler Pickett <tyler@therapylog.com>
# @since ?
module CASServer
  module ExpirationPolicies
    class AbstractExpirationPolicy
      @maximum_session_lifetime = nil
      class << self
        undef_method :new

        attr_reader :maximum_session_lifetime

        def maximum_session_lifetime=(session_lifetime)
          @maximum_session_lifetime = session_lifetime
          class << self
            undef_method :maximum_session_lifetime=
          end
        end
        
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
end
