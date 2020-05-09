require 'rails_helper'

describe 'POST /api/v1/accounts' do
  context 'when send correctly params' do
    it 'returns ok status' do
      payload = {
        name: 'corporativo',
        amount: 15000000,
        number: 12345
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
