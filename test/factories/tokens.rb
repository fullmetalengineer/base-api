# frozen_string_literal: true

FactoryBot.define do
  factory :token do
    user { nil }
    value { "MyString" }
    expiry { "2021-09-13 11:47:14" }
    ip { "MyString" }
    revocation_date { "2021-09-13 11:47:14" }
  end
end
