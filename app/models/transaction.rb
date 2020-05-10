class Transaction < ApplicationRecord
  belongs_to :account_source, class_name: 'Account'
  belongs_to :account_destination, class_name: 'Account'

  validates :amount, :account_source_id, :account_destination_id, presence: true
end
