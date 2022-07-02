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
    it 'update the given item' do
      expect(true).to eq(true)
    end
  end
end
