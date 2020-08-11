# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string
#  first_name      :string
#  last_name       :string
#  password_digest :string
#  token           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email)
#  index_users_on_token  (token)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "that each user must have a unique email" do
    alan_user = users(:alan)
    zach_user = users(:zach)

    alan_user.email = zach_user.email
    
    assert_not alan_user.save, "Was able to create a non-unique email in the database on a user"
    assert alan_user.errors.keys.include?(:email), "Saving a user with a non-unique email did not generate a model error"
  end

  test "that calling generate_token! updates the user's token value in the database" do
    alan_user = users(:alan)
    alan_user.update(token: nil)
    assert alan_user.token.nil?, "Did not nullify the user's token"
    
    alan_user.generate_token!
    assert_not alan_user.token.blank?, "Failed to generate a token"
  end

  test "that getting a user profile returns the proper keys" do
    alan_user = users(:alan)
    expected_keys = [:first_name, :last_name, :email, :token] 
    assert alan_user.profile.keys.size == 4, "Generated the wrong number of attributes on the user profile"
    assert alan_user.profile.keys - expected_keys == [], "Did not get the proper keys back"
  end

  test "that creating a user works" do
    result = UserService.create({
      first_name: "test",
      last_name: "account",
      email: "test@test.com",
      password: "MyPassword"
    })

    assert result.success? == true
    assert result.payload.class.name.to_sym == :User
  end

  test "that updating a user works" do
    result = UserService.create({
      first_name: "test",
      last_name: "account",
      email: "test@test.com",
      password: "MyPassword"
    })

    result2 = UserService.self_update(result.payload, { id: result.payload.id, first_name: "Jeff", last_name: "Portnoy", email: "test2@test.com"})
    assert result2.success?
    assert result2.payload.first_name == "Jeff"
    assert result2.payload.last_name == "Portnoy"
  end

  test "logging in a user works" do
    result = UserService.create({
      first_name: "test",
      last_name: "account",
      email: "test@test.com",
      password: "MyPassword"
    })

    login_result = UserService.login(result.payload.email, "MyPassword")
    assert login_result.success?
    assert login_result.payload.class.name.to_sym == :User
  end

  test "logging out a user works" do
    result = UserService.create({
      first_name: "test",
      last_name: "account",
      email: "test@test.com",
      password: "MyPassword"
    })

    login_result = UserService.login(result.payload.email, "MyPassword")
    assert login_result.success?
    assert login_result.payload.class.name.to_sym == :User

    logout_result = UserService.logout(login_result.payload)
    assert logout_result.success?
    assert logout_result.payload.nil?
  end
end
