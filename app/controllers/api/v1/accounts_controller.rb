module Api
  module V1
    class AccountsController < ApplicationController
      before_action :token_authenticable?, except: %i[create]

      def create
        account = Account.new(account_params)
        account.save!

        render json: format_success_data(account, 'Conta criada com sucesso'),
               status: :ok
      rescue ActiveRecord::RecordInvalid
        render json: {
          message: 'Não foi possível criar conta',
          errors: account.errors.full_messages
        }, status: :unprocessable_entity
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
        render json: { error: 'Conta não encontrada' }, status: :not_found
      end

      private

      def account_params
        params.permit(:name, :amount, :number)
      end

      def format_success_data(account, message)
        {
          account: account.number,
          message: message,
          token: account.token
        }
      end
    end
  end
end
