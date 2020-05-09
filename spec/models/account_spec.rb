require 'rails_helper'

describe Account do
  context '#create_account' do
    it 'has to create account' do
      account = build(:account, name: 'corporativo', amount: 150000)

      account.save

      expect(account.name).to eq 'corporativo'
      expect(account.amount).to eq 150000
    end
  end
end
