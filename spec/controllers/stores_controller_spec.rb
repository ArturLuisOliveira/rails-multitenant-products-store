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
    let(:store) { create(:store, description: 'Old description') }
    let(:route) { store_path(store.id) }
    let(:user) { create(:user, store:) }
    let(:headers) { create_headers_with_bearer_token(user) }
    let(:description) { 'New description' }

    context 'when the user is not logged' do
      it 'has a unauthorized status' do
        patch route, params: { description: }

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when the user is logged' do
      it 'update the given item' do
        patch route, params: { description: }, headers: headers

        store.reload
        expect(store.description).to eq(description)
      end
    end

    context 'when the user belongs to a different store' do
      let(:outside_store) { create(:store, description: 'Old description') }
      let(:route) { store_path(outside_store.id) }

      it 'has a unauthorized status' do
        patch route, params: { description: }, headers: headers

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
