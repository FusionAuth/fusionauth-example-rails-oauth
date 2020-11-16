class TokenService
  def self.decode(token)
    JWT.decode(
        token,
        nil,
        false,
        {algorithm: 'HS256'})
  end
end