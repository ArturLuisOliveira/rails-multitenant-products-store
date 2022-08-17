require 'rails_helper'

RSpec.describe StoresController, type: :request do
  describe 'GET#show' do
    let!(:store) { create(:store) }
    let(:route) { store_path(store.id) }

    it 'return the given store' do
      get route

      expect(assigns(:store)).to eq(store)
    end
  end

  describe 'PATCH#update' do
    let!(:store) { create(:store, description: 'Old description.') }
    let(:route) { store_path(store.id) }
    let!(:user) { create(:user, store:) }
    let!(:application) { create(:application) }
    let!(:token) { create(:access_token, application:, resource_owner_id: user.id) }
    let!(:headers) { { 'Authorization' => "Bearer #{token.token}" } }

    it 'update the given item' do
      description = 'New description.'
      patch route, params: { description: }, headers: headers

      store.reload
      expect(store.description).to eq(description)
    end
  end
end
