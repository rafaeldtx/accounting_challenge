require 'securerandom'

FactoryBot.define do
  factory :account do
    name { 'Corporativa' }
    amount { 150_000 }
    number { SecureRandom.random_number(10_000..99_999) }
    token { SecureRandom.uuid }
  end
end
