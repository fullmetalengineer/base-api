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

# The model that represents the User
class User < ApplicationRecord
  has_secure_password
  has_many :user_roles
  has_many :roles, through: :user_roles

  validates :email, uniqueness: true

  def generate_token!
    update_attribute :token, AppServices::AccessToken.generate(self)
  end

  def role?(role)
    roles.any? { |r| r.slug.underscore.to_sym == role }
  end

  def add_role(role)
    if role.class.name.to_sym != :Symbol
      return AppServices::ServiceContract.sign(success: false, payload: nil, errors: 'Role must be a symbol')
    end

    unless Role.valid_role?(role)
      return AppServices::ServiceContract.sign(
        success: false, payload: nil, errors: "Role of type '#{role}' is not available."
      )
    end

    target_role = Role.find_by_slug(role)
    roles << target_role unless roles.include?(target_role)
    AppServices::ServiceContract.sign(success: true, payload: roles, errors: nil)
  end

  def remove_role(role)
    if role.class.name.to_sym != :Symbol
      return AppServices::ServiceContract.sign(success: false, payload: nil, errors: 'Role must be a symbol')
    end

    unless Role.valid_role?(role)
      return AppServices::ServiceContract.sign(
        success: false, payload: nil, errors: "Role of type '#{role}' is not available."
      )
    end

    role = Role.find_by_slug(role)
    if user_roles.where(role: role).destroy_all
      AppServices::ServiceContract.sign(success: true, payload: nil, errors: nil)
    else
      AppServices::ServiceContract.sign(success: false, payload: nil, errors: "Could not destroy #{role}")
    end
  end

  def name
    "#{first_name} #{last_name}"
  end

  def profile
    {
      first_name: first_name,
      last_name: last_name,
      token: token,
      email: email
    }
  end
end
