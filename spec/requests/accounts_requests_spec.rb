require 'rails_helper'

describe 'POST /api/v1/accounts' do
  let(:payload) {
    payload = {
      name: 'corporativo',
      amount: 15000000,
      number: 12345
    }
  }
  context 'when send correctly params' do
    it 'returns ok status' do
      post '/api/v1/accounts', params: payload

      expect(response).to have_http_status(:ok)
    end

    it 'returns account number and token with message' do
      post '/api/v1/accounts', params: payload

      expect(response.body).to eq({
        account: 12345,
        message:"Conta criada com sucesso",
        token: Account.last.token
      }.to_json)
    end
  end

  context 'when send correctly params without account number' do
    it 'returns ok status' do
      payload = {
        name: 'corporativo',
        amount: 15000000
      }

      post '/api/v1/accounts', params: payload

      expect(response).to have_http_status(:ok)
    end
  end

  context 'when not send correctly params' do
    it 'returns unprocessable_entity status' do
      payload = {}

      post '/api/v1/accounts', params: payload

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end

describe 'GET /api/v1/accounts/:id' do
  context 'when has an authorized token' do
    let(:account) { create(:account) }
    let(:encoded_token) {
      ActionController::HttpAuthentication::Token
        .encode_credentials(account.token)
    }

    context 'and number account exists' do
      it 'returns ok status' do
        get "/api/v1/accounts/#{account.number}",
            headers: { 'Authorization' => encoded_token }

        expect(response).to have_http_status(:ok)
      end

      it 'returns account number and amount' do
        get "/api/v1/accounts/#{account.number}",
            headers: { 'Authorization' => encoded_token }

        expect(response.body).to eq(
          {
            data: {
              account: account.number,
              amount: account.amount
            }
          }.to_json
        )
      end
    end

    context 'and sended account number not exists' do
      it 'returns not_found status' do
        get '/api/v1/accounts/1',
          headers: { 'Authorization' => encoded_token }

        expect(response).to have_http_status(:not_found)
      end

      it 'returns message error' do
        get '/api/v1/accounts/1',
          headers: { 'Authorization' => encoded_token }

        expect(response.body).to eq({ error: 'Conta não encontrada' }.to_json)
      end
    end
  end

  context 'when has an unauthorized token' do
    it 'returns unauthorized status' do
      get "/api/v1/accounts/1234",
          headers: { 'Authorization' => 'token_invalid' }

      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns message unauthorized' do
      get "/api/v1/accounts/1234",
          headers: { 'Authorization' => 'token_invalid' }

      expect(response.body).to eq(
        { error: 'Acesso negado! Informe um Token válido!' }.to_json
      )
    end
  end
end
