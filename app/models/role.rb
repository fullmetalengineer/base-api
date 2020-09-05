# frozen_string_literal: true

# Model that stores all of the available roles
class Role < ApplicationRecord
  validates_uniqueness_of :slug, presence: true
end
