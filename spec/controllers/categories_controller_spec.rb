require 'rails_helper'

RSpec.describe CategoriesController, type: :request do
  describe 'GET#index' do
    let!(:store) { create(:store) }
    let!(:category_a) { create(:category, store:) }
    let!(:category_b) { create(:category, store:) }
    let!(:category_c) { create(:category) }
    let(:route) { categories_path }
    let(:params) { { store_id: store.id } }

    it 'returns the categories' do
      get route, params: params
      expect(assigns(:categories)).to include(category_a)
      expect(assigns(:categories)).to include(category_b)
      expect(assigns(:categories)).not_to include(category_c)
    end
  end

  describe 'POST#create' do
    let(:store) { create(:store) }
    let(:user) { create(:user, store:) }
    let(:headers) { create_headers_with_bearer_token(user) }
    let(:params) { { name: 'new name', description: 'new description' } }
    let(:route) { categories_path }

    describe 'when the user is not logged' do
      it 'has an unauthorized status' do
        post route, params: params

        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe 'when the user is logged' do
      it 'creates the given category' do
        expect { post route, params:, headers: }.to change(Category, :count).from(0).to(1)
      end
    end
  end

  describe 'PATCH#update' do
    let(:store_a) { create(:store) }
    let(:store_b) { create(:store) }

    let(:category_a) { create(:category, store: store_a) }
    let(:category_b) { create(:category, store: store_b) }

    let(:user) { create(:user, store: store_a) }
    let(:headers) { create_headers_with_bearer_token(user) }
    let(:params) { { name: 'new name', description: 'new description' } }

    describe 'when the user is not logged' do
      let(:route) { category_path(category_a) }

      it 'has an unauthorized status' do
        patch route, params: params

        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe 'when the user belongs to a different store' do
      let(:route) { category_path(category_b) }

      it 'has an unauthorized status' do
        patch route, params: params, headers: headers

        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe 'when the user is logged' do
      let(:route) { category_path(category_a) }

      it 'updates the given category' do
        patch route, params: params, headers: headers

        category_a.reload
        expect(category_a.name).to eq(params[:name])
        expect(category_a.description).to eq(params[:description])
      end
    end
  end

  # describe 'DELETE#destroy' do
  #   let(:store) { create(:store) }
  #   let(:category) { create(:category, store:) }
  #   let(:user) { create(:user, store:) }
  #   let(:route) { categories_path(category.id) }

  #   describe 'when the user is not logged' do
  #     it 'has a unauthorized status' do
  #       patch route, params: params

  #       expect(response).to have_http_status(:unauthorized)
  #     end.to change(Category, :count).from(1).to(0)
  #   end
  # end
end
