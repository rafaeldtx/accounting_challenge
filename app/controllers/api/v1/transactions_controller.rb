module Api
  module V1
    class TransactionsController < ApplicationController
      before_action :is_token_authenticable?

      def create
        transaction = Transaction.new(transaction_params)
        account_source = Account.find_by!(number: params[:account_source])
        account_destination =
          Account.find_by!(number: params[:account_destination])

        transaction.account_source = account_source
        transaction.account_destination = account_destination

        if account_source.amount < transaction.amount
          raise Exception.new
        end

        transaction.account_source.amount -= transaction.amount
        transaction.account_destination.amount += transaction.amount

        transaction.save!
        transaction.account_source.save!
        transaction.account_destination.save!

        data = {
          data: {
            account_source: transaction.account_source.number,
            account_destination: transaction.account_destination.number,
            amount: transaction.amount
          },
          message: 'Transação realizada com sucesso!'
        }

        render json: data, status: :ok
      rescue ActiveRecord::RecordInvalid
        render json: {
          errors: transaction.errors
        }, status: :unprocessable_entity
      rescue ActiveRecord::RecordNotFound
        render json: {
          errors: ['Conta não encontrada']
        }, status: :not_found
      rescue Exception
        render json: {
          errors: ['Conta não possui saldo suficiente para transação']
        }, status: :bad_request
      end

      private

      def transaction_params
        params.permit(:amount)
      end
    end
  end
end

