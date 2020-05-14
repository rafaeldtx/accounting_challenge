class TransactionService
  def new_record(transaction)
    Transaction.transaction do
      transaction.save!

      update_accounts_amount(transaction)
    end
  end

  private

  def update_accounts_amount(transaction)
    transaction.account_source.amount -= transaction.amount
    transaction.account_destination.amount += transaction.amount

    transaction.account_source.save!
    transaction.account_destination.save!

    transaction
  end
end
