ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

   def is_logged_in?
     !session[:member_id].nil?
   end

    # login to test user.
   def log_in_as(member, options = {})
      password    = options[:password]    || 'password123'
      remember_me = options[:remember_me] || '1'
      if integration_test?
      post login_path, session: { email:       member.email,
                                  password:    password,
                                  remember_me: remember_me }
     else
      session[:member_id] = member.id
     end
   end

  private

    # return to true in the integration_test
    def integration_test?
      defined?(post_via_redirect)
    end
end
