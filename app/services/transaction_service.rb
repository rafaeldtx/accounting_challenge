class TransactionService
  def new_record(transaction)
    transaction = calculate_amounts(transaction)

    Transaction.transaction do
      transaction.save!
      transaction.account_source.save!
      transaction.account_destination.save!
    end
  rescue ActiveRecord::RecordInvalid
    render json: { errors: transaction.errors }, status: :unprocessable_entity
  end

  private

  def calculate_amounts(transaction)
    transaction.account_source.amount -= transaction.amount
    transaction.account_destination.amount += transaction.amount

    transaction
  end
end
