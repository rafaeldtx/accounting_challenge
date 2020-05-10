require 'securerandom'

module Api
  module V1
    class AccountsController < ApplicationController
      def create
        account = Account.new(account_params)
        account.token = SecureRandom.uuid

        if account.number.nil?
          account.number = generate_account_number(account.number)
        end

        account.save!

        render json: { token: account, message: "Conta criada com sucesso" }, status: :ok
      rescue => exception
        render json: { message: "Não foi possível criar sua conta" },
              status: :unprocessable_entity
      end

      private

      def account_params
        params.permit(:name, :amount, :number)
      end

      def generate_account_number(number)
        while Account.where(number: number).exists? || number.nil?
          number = SecureRandom.random_number(10000..99999)
        end

        number
      end
    end
  end
end
