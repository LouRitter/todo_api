module RequestSpecHelper
  def user_login(user)
    secret = Rails.application.secrets.json_web_token_secret
    request.headers["Authorization"] = 
      JWT.encode({ user_id: user.id }, secret)
  end
  def json
    JSON.parse(response.body)
  end
end