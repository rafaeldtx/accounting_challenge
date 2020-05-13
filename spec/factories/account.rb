require 'securerandom'

FactoryBot.define do
  factory :account do
    name { 'Corporativa' }
    amount { 150000 }
    number { SecureRandom.random_number(10000..99999) }
    token { SecureRandom.uuid }
  end
end
