require 'active_support'

# @abstract Subclass and override #{ticket_expired?} to implement
#   an ExpirationPolicy
#
# @author Tyler Pickett <tyler@therapylog.com>
# @since ?
module CASServer
  module ExpirationPolicies
    class AbstractExpirationPolicy

      attr_reader :maximum_ticket_lifetime

      class << self
        # Override object's .new method.
        #
        # What we're trying to accomplish is a bit of efficeny in handling
        # these classes. We're likely to have very few different timeouts
        # but will need a lot of references to the same timeout. Since
        # nothing but the timeout is being stored the only part of this that
        # has a potential race condition is the caching portion but that
        # shouldn't prove to be a problem given that the extra instances
        # will get reaped relatively quickly by the GC.
        def new(maximum_ticket_lifetime)
          @cache ||= {}
          @cache[maximum_ticket_lifetime] ||= super(maximum_ticket_lifetime)
        end
      end

      def initialize(maximum_ticket_lifetime)
        @maximum_ticket_lifetime = maximum_ticket_lifetime
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
        raise "ticket_expired? not implemented in AbstractExpirationPolicy, please override in #{self.class.name}"
      end
    end
  end
end
