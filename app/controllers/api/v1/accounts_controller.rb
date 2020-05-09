require 'securerandom'

module Api
  module V1
    class AccountsController < ApplicationController
      def create
        account = Account.new(account_params)
        account.token = SecureRandom.uuid
        account.save!

        render json: { token: account.token, message: "Conta criada com sucesso" }, status: :ok
      rescue => exception
        puts exception
        render json: { message: "Não foi possível criar sua conta" },
              status: :unprocessable_entity
      end

      private

      def account_params
        params.permit(:name, :amount, :number)
      end
    end
  end
end
