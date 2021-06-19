class AuthenticationTokenService
    HMAC_SECRET = Rails.application.credentials.hmac_secret
    ALGORITHM_TYPE = 'HS256'

    def self.call(user_id)
        payload = {user_id: user_id}

        JWT.encode payload, HMAC_SECRET, ALGORITHM_TYPE
    end

    def self.decode(token)
        decoded_token = JWT.decode token, HMAC_SECRET, true, { algorithm: ALGORITHM_TYPE }
        decoded_token[0]['user_id']
    end
end