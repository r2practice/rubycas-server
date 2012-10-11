module CASServer
  module ExpirationPolicies
  end
end

require 'casserver/expiration_policies/abstract_expiration_policy'

CASServer::ExpirationPolicies.autoload :DefaultExpirationPolicy, 'casserver/expiration_policies/default_expiration_policy.rb'
CASServer::ExpirationPolicies.autoload :RememberMeExpirationPolicy, 'casserver/expiration_policies/remember_me_expiration_policy.rb'

# Commented out because we don't have a last_activity column yet on any of the tickets
# CASServer::ExpirationPolicies.autoload :TimeoutExpirationPolicy, 'casserver/expiration_policies/timeout_expiration_policy.rb'

