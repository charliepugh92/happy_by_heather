require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  context SessionsController do
    context '#create' do
      setup do
        @user = create(:user, password: 'password_test')
      end

      should 'log in user' do
        params = {
          session: { username: @user.username, password: 'password_test' }
        }

        post login_path, params: params

        assert_redirected_to root_path
      end

      should 'not log in and show error if no username is passed' do
        post login_path, params: { session: { password: 'password_test' } }

        assert_response :success
        assert_select '.alert-danger', I18n.t('sessions.flashes.invalid_login')
      end

      should 'not log in and show error if no password is passed' do
        post login_path, params: { session: { username: @user.username } }

        assert_response :success
        assert_select '.alert-danger', I18n.t('sessions.flashes.invalid_login')
      end

      should 'not log in and show error if password is not valid' do
        params = {
          session: { username: @user.username, password: 'bad_password' }
        }

        post login_path, params: params

        assert_response :success
        assert_select '.alert-danger', I18n.t('sessions.flashes.invalid_login')
      end
    end

    context '#new' do
      while_signed_in do
        should 'redirect to root' do
          get login_path

          assert_redirected_to root_path
        end
      end

      while_not_signed_in do
        should 'return success' do
          get login_path

          assert_response :success
        end
      end
    end
  end
end
