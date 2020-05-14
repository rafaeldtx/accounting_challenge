class Account < ApplicationRecord
  has_secure_token

  validates :name, :amount, presence: true
  validates_uniqueness_of :number, case_sensitive: true
end
