# frozen_string_literal: true

module AuthenticableUser
  private

  def current_user
    @current_user ||= begin
      User.find_by(id: payload_data["sub"]) if token && decoded_token
    end
  end

  def token
    @token ||= request.headers["Authorization"].to_s.split(" ").last
  end

  def decoded_token
    @decoded_token ||= JWT.decode(token, hmac_secret, true, decode_options)
  rescue JWT::DecodeError
    nil
  end

  def payload_data
    @payload_data ||= decoded_token.reduce({}, :merge)
  end

  def hmac_secret
    ENV["HMAC_SECRET"]
  end

  def decode_options
    {
      algorithm: ENV["HMAC_ALGORITHM"],
      verify_jti: true
    }
  end
end
