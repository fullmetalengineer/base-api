require 'test_helper'

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should log a user in' do
    post api_v1_users_login_url, params: { email: 'alan.d.long@protonmail.com', password: "MyPassword" }, as: :json
    assert_response :success

    body = JSON.parse(response.body)
    assert_not body.dig('payload', 'token').blank?, "Did not get back a valid logged in token"
  end

  test 'should not log a user in with incorrect password' do
    post api_v1_users_login_url, params: { email: @super_user.email, password: "ALM!2020" }, as: :json
    assert_response :unauthorized

    body = JSON.parse(response.body)
    assert body.dig('payload', 'token').blank?, "Should not get back a valid logged in token"
  end

  test 'should log a user out' do
    delete api_v1_users_logout_url, headers: @super_user_headers, as: :json
    assert_response :success
  end

  test 'should return the user object' do
    get api_v1_users_me_url, headers: @super_user_headers, as: :json
    assert_response :success

    body = JSON.parse(response.body)
    assert body.dig('payload', 'token').blank?, "Incorrectly exposed the user token"
    assert body.dig('payload', 'first_name') == @super_user.first_name, "Did not return the user object"
  end
end
