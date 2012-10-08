module CASServer
  module ExpirationPolicies
    class RememberMeExpirationPolicy
      attr_reader :remember_me_policy, :standard_policy

      def initialize(standard_policy, remember_me_policy)
        @standard_policy = standard_policy
        @remember_me_policy = remember_me_policy
      end

      def ticket_expired?(ticket)
        (ticket.extra_attributes[:remember_me] ? remember_me_policy.ticket_expired?(ticket) : standard_policy.ticket_expired?(ticket))
      end
    end
  end
end
