module Api
  module V1
    class AccountsController < ApplicationController
      before_action :is_token_authenticable?, except: %i[create]

      def create
        account = Account.new(account_params)
        account.save!

        data = {
          account: account.number,
          message: "Conta criada com sucesso",
          token: account.token
        }

        render json: data, status: :ok
      rescue ActiveRecord::RecordInvalid
        data = {
          message: "Não foi possível criar conta",
          errors: account.errors.full_messages
        }
        render json: data, status: :unprocessable_entity
      end

      def show
        account = Account.find_by!(number: params[:id])

        render json: {
          data: {
            account: account.number,
            amount: account.amount
          }
        }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: {
          error: 'Conta não encontrada'
        }, status: :not_found
      end

      private

      def account_params
        params.permit(:name, :amount, :number)
      end
    end
  end
end
