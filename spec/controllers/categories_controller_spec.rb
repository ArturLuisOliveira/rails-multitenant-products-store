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

  # describe 'PATCH#update' do
  #   let(:store) { create(:store) }
  #   let(:category) { create(:category, store:) }
  #   let(:user) { create(:user, store:) }
  #   let(:headers) { create_headers_with_bearer_token(user) }
  #   let(:params) { { name: 'new name', description: 'new description' } }
  #   let(:route) { categories_path(category) }

  #   describe 'when the user is not logged' do
  #     it 'has a unauthorized status' do
  #       patch route, params: params

  #       expect(response).to have_http_status(:unauthorized)
  #     end
  #   end

  #   describe 'when the user belongs to a different store' do
  #     it 'has a unauthorized status' do
  #       patch route, params: params, headers: headers

  #       expect(response).to have_http_status(:unauthorized)
  #     end
  #   end

  #   describe 'when the user is logged' do
  #     it 'updates the given category' do
  #       patch route, params: params, headers: headers

  #       category.reload
  #       expect(category.name).to eq(params[:name])
  #       expect(category.description).to eq(params[:description])
  #     end
  #   end
  # end

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
