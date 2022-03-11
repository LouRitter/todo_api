RSpec.describe 'Users', type: :request do
  describe 'post users/' do
    it 'creates the user' do
      post '/users', params: { email: "test@example.com", password: "password"}      
      expect(response).to have_http_status(:ok)
      expect(json).to include({
        'id' => User.last.id,
        'email' => 'test@example.com',
      })
    end
  end
  
end