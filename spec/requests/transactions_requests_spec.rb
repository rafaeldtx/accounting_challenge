require 'rails_helper'

describe 'POST /api/v1/transactions' do
  context 'when has an authorized token' do
    context 'and send correctly params' do
      it 'returns ok status' do
        account_source = create(:account, number: 1234, amount: 140000)
        account_destination = create(:account, number: 4321, amount: 80000)
        payload = {
          amount: 20000,
          account_source: account_source.number,
          account_destination: account_destination.number
        }
        encoded_token = ActionController::HttpAuthentication::Token
            .encode_credentials(account_source.token)

        post '/api/v1/transactions',
          params: payload, headers: { 'Authorization' => encoded_token }

        expect(response).to have_http_status(:ok)
      end

      it 'update amount of involved accounts', :aggregate_failures do
        account_source = create(:account, number: 1234, amount: 140000)
        account_destination = create(:account, number: 4321, amount: 80000)
        payload = {
          amount: 20000,
          account_source: account_source.number,
          account_destination: account_destination.number
        }
        encoded_token = ActionController::HttpAuthentication::Token
            .encode_credentials(account_source.token)

        post '/api/v1/transactions',
          params: payload, headers: { 'Authorization' => encoded_token }

        expect(account_source.reload.amount).to eq(120000)
        expect(account_destination.reload.amount).to eq(100000)
      end

      it 'returns ok status' do
        account_source = create(:account, number: 1234, amount: 140000)
        account_destination = create(:account, number: 4321, amount: 80000)
        payload = {
          amount: 20000,
          account_source: account_source.number,
          account_destination: account_destination.number
        }

        encoded_token = ActionController::HttpAuthentication::Token
          .encode_credentials(account_source.token)

        post '/api/v1/transactions',
          params: payload, headers: { 'Authorization' => encoded_token }

        expect(response).to have_http_status(:ok)
      end
    end

    context 'and not send correctly accounts param' do
      it 'returns unprocessable_entity status' do
        account_source = create(:account, number: 1234, amount: 40000)
        payload = {}

        encoded_token = ActionController::HttpAuthentication::Token
          .encode_credentials(account_source.token)

        post '/api/v1/transactions',
          params: payload, headers: { 'Authorization' => encoded_token }

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'and account source has insufficient founds' do
      it 'raise bad_request exception' do
        account_source = create(:account, number: 1234, amount: 40000)
        account_destination = create(:account, number: 4321, amount: 10000)
        payload = {
          amount: 40100,
          account_source: account_source.number,
          account_destination: account_destination.number
        }

        encoded_token = ActionController::HttpAuthentication::Token
          .encode_credentials(account_source.token)

        post '/api/v1/transactions',
          params: payload, headers: { 'Authorization' => encoded_token }

        expect(response).to have_http_status(:bad_request)
      end

      it 'not update amount of involved accounts', :aggregate_failures do
        account_source = create(:account, number: 1234, amount: 40000)
        account_destination = create(:account, number: 4321, amount: 10000)
        payload = {
          amount: 40100,
          account_source: account_source.number,
          account_destination: account_destination.number
        }

        post '/api/v1/transactions', params: payload

        expect(account_source.reload.amount).to eq(40000)
        expect(account_destination.reload.amount).to eq(10000)
      end
    end
  end

  context 'when has an unauthorized token' do
    it 'returns unauthorized status' do
      post "/api/v1/transactions",
        headers: { 'Authorization' => 'token_invalid' }

      expect(response).to have_http_status(:unauthorized)
    end

    it 'and returns message unauthorized' do
      post "/api/v1/transactions",
        headers: { 'Authorization' => 'token_invalid' }

      expect(response.body).to eq(
        { error: 'Acesso negado! Informe um Token válido!' }.to_json
      )
    end
  end
end
