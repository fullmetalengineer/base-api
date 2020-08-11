require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = users(:alan)
    @user_headers = { "Authorization": "Bearer #{@user.token}"}
  end

  test "should log a user in" do
    skip
    # post api_v1_users_login_url, params: { email: @user.email, password: 'BOM!2020' }, as: :json
    # assert_response :success

    # body = JSON.parse(response.body)
    # assert_not body.dig('token').blank?, "Did not get back a valid logged in token"
  end

  test "should log a user out" do
    skip
    # delete api_v1_users_logout_url, headers: @user_headers, as: :json
    # assert_response :success
  end

  test "should return the logged in user's profile" do
    skip
    # get api_v1_users_me_url, headers: @user_headers, as: :json
    # assert_response :success

    # body = JSON.parse(response.body)
    # assert_not body.dig('token').blank?, "Did not get a valid logged in user"
    # assert body.dig('id') == @user.id, "Got back the wrong user"
  end

  test "should create a user" do
    skip
    # get api_v1_users_me_url, headers: @user_headers, as: :json
    # assert_response :success

    # body = JSON.parse(response.body)
    # assert_not body.dig('token').blank?, "Did not get a valid logged in user"
    # assert body.dig('id') == @user.id, "Got back the wrong user"
  end
end