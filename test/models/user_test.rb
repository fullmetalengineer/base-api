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
  # ====================================== VALIDATIONS ======================================
  test 'that each user must have a unique email' do
    alan_user = users(:alan)
    zach_user = users(:zach)

    alan_user.email = zach_user.email

    assert_not alan_user.save, 'Was able to create a non-unique email in the database on a user'
    assert alan_user.errors.keys.include?(:email), 'Saving a user with a non-unique email did not generate a model error'
  end

  test "that calling generate_token! updates the user's token value in the database" do
    alan_user = users(:alan)
    alan_user.update(token: nil)
    assert alan_user.token.nil?, "Did not nullify the user's token"

    alan_user.generate_token!
    assert_not alan_user.token.blank?, 'Failed to generate a token'
  end

  # ====================================== AUTH ======================================

  test 'logging in a user works' do
    result = User.create(
      first_name: 'test',
      last_name: 'account',
      email: 'test@test.com',
      password: 'MyPassword'
    )

    login_result = BaseApi::Auth.login(result.email, 'MyPassword')
    assert login_result.success?
    assert login_result.payload.class.name.to_sym == :User
  end

  test 'logging out a user works' do
    result = User.create(
      first_name: 'test',
      last_name: 'account',
      email: 'test@test.com',
      password: 'MyPassword'
    )

    login_result = BaseApi::Auth.login(result.email, 'MyPassword')
    assert login_result.success?
    assert login_result.payload.class.name.to_sym == :User

    logout_result = BaseApi::Auth.logout(login_result.payload)
    assert logout_result.success?
    assert logout_result.payload
  end

  # ====================================== ROLES ======================================

  test 'giving a user a role works' do
    zach = users(:zach)
    role_result = zach.add_role(:admin)

    assert role_result.success?, 'did not successfully give user Zach the Admin role'
    assert role_result.errors.none?, "error when assigning user Zach the admin role: #{role_result.errors.as_sentence}"
  end

  test 'removing a role from a user works' do
    zach = users(:zach)
    role_result = zach.remove_role(:user)

    assert role_result.success?, 'did not successfully remove the user role from Zach'
    assert role_result.errors.none?, "error when removing user role from Zach: #{role_result.errors.as_sentence}"
  end

  test 'giving a user the same role multiple times is ok' do
    zach = users(:zach)
    role_result = zach.add_role(:user)

    assert role_result.success?, 'did not error when assigning the same role multiple times'
    assert role_result.errors.none?, "error when assigning the same role multiple times: #{role_result.errors.as_sentence}"
  end

  test 'removing a role the user does not have does not result in an error' do
    zach = users(:zach)
    role_result = zach.remove_role(:admin)

    assert role_result.success?, 'error when removing a role the user didnt have'
    assert role_result.errors.none?, "error when removing a role the user didnt have: #{role_result.errors.as_sentence}"
  end
end
