class Account < ApplicationRecord
  validates :name, :amount, :token, presence: true
  validates :number, :token, uniqueness: true
end
