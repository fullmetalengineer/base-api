# frozen_string_literal: true

module BaseApi
  # Generates a random access token
  module AccessToken
    def self.generate(model)
      Digest::SHA256.hexdigest(SecureRandom.uuid)
    end
  end
end
