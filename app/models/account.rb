class Account < ApplicationRecord
  validates :name, :amount, :number, :token, presence: true
  validates :number, :token, uniqueness: true
end
