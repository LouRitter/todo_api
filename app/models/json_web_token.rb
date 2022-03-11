class JsonWebToken
  SECRET = Rails.application.secrets.secret_key_base.to_s

  def self.encode(payload, exp = 72.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET)[0]
    HashWithIndifferentAccess.new decoded
  end

end