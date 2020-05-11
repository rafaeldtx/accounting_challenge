class Account < ApplicationRecord
  has_many :account_sources, class_name: 'Transaction', foreign_key: :account_source_id
  has_many :account_destinations, class_name: 'Transaction', foreign_key: :account_destination_id

  validates :name, :amount, :token, presence: true
  validates_uniqueness_of :number, :token, case_sensitive: true
end
