class TokenDecoder

  def initialize(token, aud)
    @token = token
    @aud = aud
    @iss = 'fusionauth.io'
  end

  def decode
    begin
      JWT.decode(
          @token,
          Rails.configuration.x.oauth.hmac,
          true,
          {
              verify_iss: true,
              iss: @iss,
              verify_aud: true,
              aud: @aud,
              algorithm: 'HS256'})
    rescue JWT::VerificationError
      puts "verification error"
      raise
    rescue JWT::DecodeError
      puts "bad stuff happened"
      raise
    end
  end
end