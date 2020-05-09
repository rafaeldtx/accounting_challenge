require 'securerandom'

FactoryBot.define do
  factory :account do
    name { 'Corporativa' }
    amount { 150000 }
    number { 12345 }
    token { SecureRandom.uuid }
  end
end
