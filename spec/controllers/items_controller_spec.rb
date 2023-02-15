# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ItemsController, type: :request do
  describe 'GET#index' do
    let(:route) { items_path }
    let(:store) { create(:store) }
    let(:category) { create(:category) }
    let!(:item_a) { create(:item, store:, category:) }
    let!(:item_b) { create(:item, store:, category:) }
    let!(:item_c) { create(:item, category:) }
    let(:params) { { store_id: store.id } }

    it 'return the given items' do
      get route, params: params

      expect(assigns(:items)).to include(item_a)
      expect(assigns(:items)).to include(item_b)
    end

    it 'has a ok status' do
      get route, params: params

      expect(response).to have_http_status(:ok)
    end

    it "don't return the items of other stores" do
      get route, params: params

      expect(assigns(:items)).not_to include(item_c)
    end
  end

  describe 'GET#show' do
    let(:route) { item_path(item.id) }
    let(:store) { create(:store) }
    let(:category) { create(:category) }
    let(:item) { create(:item, store:, category:) }
    let(:params) { { store_id: store.id } }

    it 'return the given item' do
      get route, params: params

      expect(assigns(:item)).to eq(item)
    end

    it 'has a ok status' do
      get route, params: params

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PATCH#update' do
    context 'when the user is not logged' do
      let(:route) { item_path(item.id) }
      let(:store) { create(:store) }

      context 'there is a item' do
        let(:item) { create(:item, store:) }

        it 'has a unauthorized status' do
          patch route, params: { name: 'New name' }

          expect(response).to have_http_status(:unauthorized)
        end
      end
    end

    context 'when the user is logged' do
      let(:store) { create(:store) }
      let(:user) { create(:user, store:) }
      let(:headers) { create_headers_with_bearer_token(user) }

      context 'when the item is from the user store' do
        let(:item) { create(:item, store:) }
        let(:route) { item_path(item.id) }
        let(:params) { { name: 'New name' } }

        it 'updates the given item' do
          patch route, params: params, headers: headers
          item.reload

          expect(item.name).to eq('New name')
        end

        it 'has a ok status' do
          patch route, params: params, headers: headers

          expect(response).to have_http_status(:ok)
        end

        it 'returns the updated item' do
          patch route, params: params, headers: headers

          expect(JSON.parse(response.body)).to include(
            'id',
            'name',
            'description',
            'aditional_info'
          )
        end
      end

      context 'when the item is not from the user store' do
        let(:item) { create(:item) }
        let(:route) { item_path(item.id) }
        let(:params) { { name: 'New name' } }

        it 'has a unauthorized status' do
          patch route, params: params, headers: headers

          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end

  describe 'DELETE#destroy' do
    let(:route) { item_path(item.id) }
    let(:store) { create(:store) }
    let(:category) { create(:category) }
    let(:item) { create(:item, store:, category:) }
    let(:user) { create(:user, store:) }
    let(:headers) { create_headers_with_bearer_token(user) }

    context 'when the user is not logged' do
      it 'has a unauthorized status' do
        delete route

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when the user is logged' do
      it 'deletes the given item' do
        delete route, headers: headers

        expect(Item.find_by(id: item.id)).to be_nil
      end

      it 'has a ok status' do
        delete route, headers: headers

        expect(response).to have_http_status(:ok)
      end

      it 'returns the deleted item' do
        delete route, headers: headers

        expect(JSON.parse(response.body)).to include(
          'id',
          'name',
          'description',
          'aditional_info'
        )
      end
    end

    context 'when the item belongs to a different store' do
      let(:item) { create(:item) }
      let(:route) { item_path(item.id) }

      it 'has a unauthorized status' do
        delete route, headers: headers

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  # describe 'POST#create' do
  #   let(:route) { items_path }
  #   let(:store) { create(:store) }
  #   let(:category) { create(:category) }
  #   let(:user) { create(:user, store:) }
  #   let(:headers) { create_headers_with_bearer_token(user) }
  #   let(:item_params) do
  #     {
  #       name: 'Item name',
  #       description: 'Item description',
  #       price: 100,
  #       category_id: category.id
  #     }
  #   end

  #   context 'when the user is not logged' do
  #     xit 'has a unauthorized status' do
  #       post route, params: item_params

  #       expect(response).to have_http_status(:unauthorized)
  #     end
  #   end

  #   context 'when the user is logged' do
  #     xit 'creates the given item' do
  #       post route, params: item_params, headers: headers

  #       expect(Item.last.name).to eq('Item name')
  #     end
  #   end
  # end
end
