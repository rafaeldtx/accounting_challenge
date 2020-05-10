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

        data = { account: account, message: "Conta criada com sucesso" }

        render json: data, status: :ok
      rescue ActiveRecord::RecordInvalid
        data = {
          message: "Não foi possível criar conta",
          errors: account.errors
        }
        render json: data, status: :unprocessable_entity
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
