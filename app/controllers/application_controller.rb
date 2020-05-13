include ActionController::HttpAuthentication::Token::ControllerMethods

class ApplicationController < ActionController::API
  private

  def token_authentication
    authenticate_with_http_token do |token, _options|
      Account.find_by(token: token).present?
    end
  end

  def is_token_authenticable?
    return true if token_authentication

    render json: {
      error: 'Acesso negado! Informe um Token válido!'
    }, status: :unauthorized
  end
end
