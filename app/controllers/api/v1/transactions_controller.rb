module Api
  module V1
    class TransactionsController < ApplicationController
      before_action :token_authenticable?

      def create
        new_transaction = set_transaction

        TransactionService.new.new_record(new_transaction)

        render json: response_data(new_transaction), status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { errors: ['Conta não encontrada'] }, status: :not_found
      end

      private

      def transaction_params
        params.permit(:amount)
      end

      def set_transaction
        Transaction.new(
          account_source: Account.find_by!(number: params[:account_source]),
          account_destination: Account.find_by!(
            number: params[:account_destination]
          ),
          amount: params[:amount]
        )
      end

      def response_data(transaction)
        {
          data: {
            account_source: transaction.account_source.number,
            account_destination: transaction.account_destination.number,
            amount: transaction.amount
          },
          message: 'Transação realizada com sucesso!'
        }
      end
    end
  end
end
