FactoryBot.define do
  factory :transaction do
    amount { 20000 }
    account { create(:account) }
    receiver { create(:account) }
  end
end
