RSpec.describe 'Tasks', type: :request do
  # initialize test data
  let!(:user) { create(:user) }

  let!(:tasks) { create_list(:task, 5, :completed, user: user) + create_list(:task, 5, :uncompleted, user: user) }
  let(:task_id) { tasks.first.id }

  describe 'GET /tasks' do
    before { get '/tasks', headers: {'Authorization'=> JsonWebToken.encode(user_id: user.id)} }
    it 'returns tasks' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
  describe 'GET /completed_tasks' do
    before { get '/completed_tasks', headers: {'Authorization'=> JsonWebToken.encode(user_id: user.id)} }
    it 'returns tasks' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
  describe 'GET /uncompleted_tasks' do
    before { get '/uncompleted_tasks', headers: {'Authorization'=> JsonWebToken.encode(user_id: user.id)} }
    it 'returns tasks' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /tasks/:id' do
    before { get "/tasks/#{task_id}", headers: {'Authorization'=> JsonWebToken.encode(user_id: user.id)} }
    context 'when task exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'returns the task item' do
        expect(json['id']).to eq(task_id)
      end
    end
    context 'when task does not exist' do
      let(:task_id) { 99 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
      it 'returns a not found message' do
        expect(response.body).to include("not_found")
      end
      

    end
  end
  describe 'POST /tasks/:id' do
    let(:valid_attributes) do
      { title: 'Clean Kitchen', notes: 'note' }
    end
    context 'when request attributes are valid' do
      before { post '/tasks', params: valid_attributes, headers: {'Authorization'=> JsonWebToken.encode(user_id: user.id)}}
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
    context 'when an invalid request' do
      before { post '/tasks', params: {title: ""}, headers: {'Authorization'=> JsonWebToken.encode(user_id: user.id)} }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
      it 'returns a failure message' do
        expect(response.body).to include("can't be blank")
      end
    end
  end
  describe 'PUT /tasks/:id' do
    let(:valid_attributes) { { title: 'mow the lawn', notes: "here", completed: true } }
    before { put "/tasks/#{task_id}", params: valid_attributes, headers: {'Authorization'=> JsonWebToken.encode(user_id: user.id)} }
    context 'when task exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'updates the task' do
        updated_item = Task.find(task_id)
        expect(updated_item.title).to match(/mow the lawn/)
        expect(updated_item.notes).to match(/here/)
        expect(updated_item.completed).to match(true)

      end
    end
    context 'when the task does not exist' do
      let(:task_id) { 0 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
      it 'returns a not found message' do
        expect(response.body).to include("not_found")
      end
    end
  end
  describe 'DELETE /tasks/:id' do
    before { delete "/tasks/#{task_id}", headers: {'Authorization'=> JsonWebToken.encode(user_id: user.id)} }
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
 end