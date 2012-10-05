require 'active_support'

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

        def ticket_expired?(ticket)
          raise "ticket_expired? not implemented in AbstractExpirationPolicy, please override in #{self.name}"
        end
      end
    end
  end
end
