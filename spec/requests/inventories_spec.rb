require 'rails_helper'

RSpec.describe 'Inventory', type: :request do
  before do
    @user = User.create(name: 'Test', email: 'test2@example.com', password: 'password')
    sign_in @user
  end

  describe 'GET /inventories' do
    it 'should respond with success' do
      get '/inventories'
      expect(response).to have_http_status(:success)
    end

    it 'should render correct template' do
      get '/inventories'
      expect(response).to render_template('index')
    end
  end

  describe 'GET /inventories/:id' do
    let(:inventory) do
      Inventory.create(user: @user, name: 'test inventory',
                       description: 'test description')
    end

    it 'should respond with success' do
      get inventory_path(inventory)
      expect(response).to have_http_status(:success)
    end

    it 'should render correct template' do
      get inventory_path(inventory)
      expect(response).to render_template('show')
    end

    it 'should include recipe name in the response body' do
      get inventory_path(inventory)
      expect(response.body).to include('test inventory')
    end
  end
  describe 'POST /inventory' do
    it 'creates a new inventory' do
      expect do
        post '/inventories',
             params: {
               inventory: {
                 name: 'New Inventory',
                 description: 'New inventory description',
                 user_id: @user.id
               }
             }
      end.to change { Inventory.count }.by(1)

      created_inventory = Inventory.last
      expect(created_inventory.name).to eq('New Inventory')
      expect(created_inventory.description).to eq('New inventory description')
      expect(created_inventory.user_id).to eq(@user.id)
    end

    it 'redirects to the created inventory' do
      post '/inventories',
           params: {
             inventory: {
               name: 'New Inventory',
               description: 'New inventory description',
               user_id: @user.id
             }
           }
      created_inventory = Inventory.last
      expect(response).to redirect_to(inventory_path(created_inventory))
    end
  end

  describe 'DELETE /inventories/:id' do
    let!(:inventory) do
      Inventory.create(user: @user, name: 'test recipe', description: 'test description')
    end

    it 'deletes a recipe' do
      expect do
        delete inventory_path(inventory)
      end.to change(Inventory, :count).by(-1)

      expect(response).to redirect_to(inventories_path)
    end
  end
end
