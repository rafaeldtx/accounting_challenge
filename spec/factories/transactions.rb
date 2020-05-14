FactoryBot.define do
  factory :transaction do
    amount { 20_000 }
    account_source { create(:account) }
    account_destination { create(:account) }
  end
end
