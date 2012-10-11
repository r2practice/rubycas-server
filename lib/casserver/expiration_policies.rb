module CASServer
  module ExpirationPolicies
  end
end

require 'casserver/expiration_policies/abstract_expiration_policy'

# We'll also need to pull in the Timeout based one eventually but 
# since we don't have the column in place yet I'll hold off
%w{default_expiration_policy remember_me_expiration_policy}.each do |policy|
  require "casserver/expiration_policies/#{policy}"
end

