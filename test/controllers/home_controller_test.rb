require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  context HomeController do
    context '#index' do
      context 'while not logged in' do 
        should 'redirect to login' do
          get root_path

          assert_redirected_to login_path
        end
      end

      context 'while signed in' do
        setup do
          
        end
      end
    end
  end
end
