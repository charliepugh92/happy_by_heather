require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  context SessionsController do
    context '#create' do
      should 'log in user' do
        user = User.create(username: 'charlie', email: 'charliepugh92@gmail.com', password: 'testword', password_confirmation: 'testword')

        post login_path, params: { session: { username: 'charlie', password: 'testword' } }

        assert_redirected_to root_path
      end
    end
  end
end
