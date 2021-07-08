class TokenDecoder

  def initialize(token, aud)
    @token = token
    @aud = aud
    @iss = 'fusionauth.io'
  end

  def decode
    begin
      jwt = JWT.decode(
        @token,
        Rails.configuration.x.oauth.hmac,
        true,
        {
          verify_iss: true,
          iss: @iss,
          verify_aud: true,
          aud: @aud,
          algorithm: 'HS256'})
      claims = jwt[0]
      if claims["applicationId"] != @aud
        # user is not registered
        Rails.logger.warn("User not registered")
        raise NotRegisteredError 
      end
      return jwt
    rescue JWT::VerificationError
      Rails.logger.warn("Verification error")
      raise
    rescue JWT::DecodeError
      Rails.logger.warn("Decode failed")
      raise
    end
  end
end

class NotRegisteredError < StandardError
  def initialize(msg="User isn't registered")
    super
  end
end


