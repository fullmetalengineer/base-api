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
    update_attribute :token, BaseApi::AccessToken.generate(self)
  end

  def role?(role)
    roles.any? { |r| r.slug.underscore.to_sym == role }
  end

  def add_role(role)
    return ServiceContract.error('Role must be a symbol') if role.class.name.to_sym != :Symbol
    return ServiceContract.error("Role of type '#{role}' is not available.") unless Role.valid_role?(role)

    target_role = Role.find_by_slug(role)
    roles << target_role unless roles.include?(target_role)
    ServiceContract.success(roles)
  end

  def remove_role(role)
    return ServiceContract.error('Role must be a symbol') if role.class.name.to_sym != :Symbol
    return ServiceContract.error("Role of type '#{role}' is not available.") unless Role.valid_role?(role)

    role = Role.find_by_slug(role)
    if user_roles.where(role: role).destroy_all
      ServiceContract.sign(success: true, payload: nil, errors: nil)
    else
      ServiceContract.sign(success: false, payload: nil, errors: "Could not destroy #{role}")
    end
  end

  def name
    "#{first_name} #{last_name}"
  end
end
