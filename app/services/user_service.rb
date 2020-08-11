module UserService
  def self.login(email, password)
    # will return nil if no user found, will return false if the try authenticate doesn't work
    user = User.find_by(email: email).try(:authenticate, password)

    # return OpenStruct.new({success?: false, error: CustomError.new("User removed")}) if user.discarded?

    return OpenStruct.new({success?: false, error: CustomError.new("User not found")}) if user.nil?
    return OpenStruct.new({success?: false, error: CustomError.new("Incorrect password")}) unless user

    # generate the token on the user obj
    user.generate_token!
    OpenStruct.new({success?: true, payload: user})
  end

  def self.logout(user)
    return OpenStruct.new({success?: true, payload: nil}) if user.update(token: nil)
    return OpenStruct.new({success?: false, error: CustomError.new("Error logging user out")})
  end

  # ============== CRUD ==============

  def self.create(param_hash)
    new_user = User.new(
      first_name: param_hash[:first_name],
      last_name: param_hash[:last_name],
      email: param_hash[:email].downcase,
      password: param_hash[:password],
      password_confirmation: param_hash[:password]
    )

    return OpenStruct.new({ success?: true, payload: new_user}) if new_user.save
    return OpenStruct.new({ success?: false, error: CustomError.new.convert(new_user.errors)})
  end

  # Allow the user to change certain non-credential fields themselves
  def self.self_update(current_user, param_hash)
    # Acceptable keys to update
    updateable_keys = [:first_name, :last_name].freeze
    # Delete out keys that have nil values
    user_params = param_hash.slice(*updateable_keys).delete_if { |k,v| v.nil? }

    # Check to make sure the user is authorized to update the user
    return OpenStruct.new({
      success?: false, 
      error: CustomError.new("You are not authorized to update this user")
    }) unless current_user.id == param_hash[:id].to_i

    # If we successfully update the user
    return OpenStruct.new({ success?: true, payload: current_user}) if current_user.update(user_params)

    # If we don't successfully update the user
    return OpenStruct.new({ success?: false, error: CustomError.new.convert(current_user.errors)})
  end

  # def self.change_role(params)
  #   # Find id of admin role
  #   role = Role.find_by(slug: "admin")
  #   error_message = nil
  #   begin
  #       user = User.find(params[:id])
  #   rescue ActiveRecord::RecordNotFound => e
  #       error_message = e.message
  #   end
  #   # If we couldn't find the user, return a message
  #   return OpenStruct.new({ success?: false, payload: CustomError.new(error_message)}) unless error_message.blank?
  #   # Define object to create
  #   new_user_role = UsersRole.new(
  #     user_id: user.id,
  #     role_id: role.id
  #   )
  #   # If role is successfully saved
  #   return OpenStruct.new({ success?: true, payload: new_user_role}) if new_user_role.save
  #   # If the role is not saved
  #   return OpenStruct.new({ success?: false, payload: CustomError.new.("Role Change was not successfull")})
  # end

  # def self.set_password(params)
  #   # Find user to set password for 
  #   user = User.valid_tokens.find_by(invitation_token: params[:invitation_token])
  #   # If no user is found, return invalid token error
  #   return OpenStruct.new({success?: false, payload: CustomError.new("Invalid Token, Please Contact Administrator")}) if user.nil?
  #   user.generate_token!
  #   # If we successfully update the user
  #   return OpenStruct.new({ success?: true, payload: user}) if user.update({password: params[:password]})
  #   # If we don't successfully update the user
  #   return OpenStruct.new({ success?: false, payload: CustomError.new.("Password Failed to Save, Try Again")})
  # end
end
