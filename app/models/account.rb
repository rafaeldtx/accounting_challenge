class Account < ApplicationRecord
  has_secure_token

  validates :name, :amount, presence: true
  validates :number, uniqueness: true

  before_validation(on: :create) do
    generate_account_number(number) if number.nil?
  end

  private

  def generate_account_number(number)
    while Account.where(number: number).exists? || number.nil?
      number = SecureRandom.random_number(10_000..99_999)
    end

    number
  end
end
