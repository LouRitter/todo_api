RSpec.describe 'Authentications', type: :request do
  describe 'post /login' do
    let(:user) { FactoryBot.create(:user, email: 'test@example.com', password: 'password') }
    it 'authenticates the user' do
      post '/auth/login', params: { email: user.email, password: 'password' }
      expect(response).to have_http_status(:ok)
      expect(json).to include({
                           'email' => 'test@example.com',
                           'token' => JsonWebToken.encode(user_id: user.id)
                         })
    end
    it 'returns error when email does not exist' do
      post '/auth/login', params: { username: 'incorrect@example.com', password: 'password' }
      expect(response).to have_http_status(:unauthorized)
      expect(json).to eq({
                           'error' => 'Incorrect Credentials'
                         })
    end
    it 'returns error when password is incorrect' do
      post '/auth/login', params: { username: user.email, password: 'incorrect' }
      expect(response).to have_http_status(:unauthorized)
      expect(json).to eq({
                           'error' => 'Incorrect Credentials'
                         })
    end
  end
 end