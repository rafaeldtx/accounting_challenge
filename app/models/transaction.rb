class Transaction < ApplicationRecord
  belongs_to :account_source, class_name: 'Account'
  belongs_to :account_destination, class_name: 'Account'

  validates :amount, :account_source_id, :account_destination_id, presence: true
  validate :account_source_amount, on: :create

  private

  def account_source_amount
    return unless account_source.present? && account_source.amount < amount

    errors.add(
      :account_source_amount, 'Conta não possui saldo para transferência'
    )
  end
end
