module Api
  module V1
    class AccountsController < ApplicationController
      before_action :token_authenticable?, except: %i[create]

      def create
        account = Account.new(account_params)
        account.save!

        render json: create_response_data(account), status: :ok
      rescue ActiveRecord::RecordInvalid
        render json: {
          message: 'Não foi possível criar conta',
          errors: account.errors.full_messages
        }, status: :unprocessable_entity
      end

      def show
        account = Account.find_by!(number: params[:id])

        render json: show_response_data(account), status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Conta não encontrada' }, status: :not_found
      end

      private

      def account_params
        params.permit(:name, :amount, :number)
      end

      def create_response_data(account)
        {
          account: account.number,
          message: 'Conta criada com sucesso',
          token: account.token
        }
      end

      def show_response_data(account)
        {
          data: {
            account: account.number,
            amount: account.amount.to_f / 100
          }
        }
      end
    end
  end
end
