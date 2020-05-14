class Account < ApplicationRecord
  has_secure_token

  validates :name, :amount, presence: true
  validates_uniqueness_of :number, case_sensitive: true

  before_validation(on: :create) do
    if self.number.nil?
      self.number = generate_account_number(self.number)
    end
  end

  private

  def generate_account_number(number)
    while Account.where(number: number).exists? || number.nil?
      number = SecureRandom.random_number(10000..99999)
    end

    number
  end
end
