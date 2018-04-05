ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/pride'

module ActiveSupport
  class TestCase
    # Setup all fixtures in test/fixtures/*.yml
    fixtures :all

    # Add more helper methods to be used by all tests here...
    include FactoryBot::Syntax::Methods
  end
end

module ActionDispatch
  class IntegrationTest
    include FactoryBot::Syntax::Methods

    def self.while_signed_in(&block)
      context 'while signed in' do
        setup do
          user = create(:user, password: 'logmein')
          params = {
            session: { username: user.username, password: 'logmein' }
          }

          post login_path, params: params
        end

        merge_block(&block) if block_given?
      end
    end

    def self.while_not_signed_in(&block)
      context 'while not signed in' do
        merge_block(&block) if block_given?
      end
    end
  end
end
