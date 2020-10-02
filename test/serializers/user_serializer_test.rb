require 'test_helper'

class UserSerializerTest < ActiveSupport::TestCase
  test 'base user serializer returns expected results' do
    user = users(:alan)

    alan_hash = UserBlueprint.render_as_hash(user)
    required_keys = %i[id first_name last_name name email]
    missing_keys = required_keys - alan_hash.keys

    assert missing_keys.blank?, "UserBlueprint didn't return the required key(s): #{missing_keys}"
  end

  test 'user serializer login view returns base keys plus token expected results' do
    user = users(:alan)

    alan_hash = UserBlueprint.render_as_hash(user, view: :login)
    alan_hash.keys.include?(:token)

    assert alan_hash.keys.include?(:token), "UserBlueprint didn't return the token"
  end
end
