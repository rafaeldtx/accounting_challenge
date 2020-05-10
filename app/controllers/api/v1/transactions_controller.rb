module Api
  module V1
    class TransactionsController < ApplicationController
      def create
        transaction = Transaction.new(transaction_params)
        account_source = Account.find_by!(number: params[:account_source])
        account_destination =
          Account.find_by!(number: params[:account_destination])

        transaction.account_source = account_source
        transaction.account_destination = account_destination

        transaction.account_source.amount -= transaction.amount
        transaction.account_destination.amount += transaction.amount

        transaction.save!
        transaction.account_source.save!
        transaction.account_destination.save!

        data = {
          transaction: transaction,
          message: 'Transação realizada com sucesso!'
        }

        render json: data, status: :ok
      rescue ActiveRecord::RecordInvalid
        render json: { errors: transaction.errors }, status: :unprocessable_entity
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Conta não encontrada' }, status: :not_found
      end

      private

      def transaction_params
        params.permit(:amount)
      end
    end
  end
end

