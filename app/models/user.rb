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

class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true

  def generate_token!
    update_attribute :token, AppServices::AccessToken.generate(self)
  end

  def profile
    {
      first_name: self.first_name,
      last_name: self.last_name,
      token: self.token,
      email: self.email
    }
  end
end
