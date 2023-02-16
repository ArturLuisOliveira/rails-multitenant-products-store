# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoriesController, type: :request do
  describe 'GET#index' do
    let(:route) { categories_path }

    context 'when the given stores have categories' do
      let!(:store) { create(:store) }
      let!(:category_a) { create(:category, store:) }
      let!(:category_b) { create(:category, store:) }
      let!(:category_c) { create(:category) }
      let(:params) { { store_id: store.id } }

      it 'returns the categories' do
        get route, params: params

        expect(assigns(:categories)).to include(category_a)
        expect(assigns(:categories)).to include(category_b)
      end

      it 'has a success status' do
        get route, params: params

        expect(response).to have_http_status(:success)
      end

      it "don't return the categories of other stores" do
        get route, params: params

        expect(assigns(:categories)).not_to include(category_c)
      end
    end
  end

  describe 'POST#create' do
    let(:params) { { name: 'new name', description: 'new description' } }
    let(:route) { categories_path }

    context 'given a store' do
      let(:store) { create(:store) }

      context 'when the user is not logged' do
        it 'has an unauthorized status' do
          post route, params: params

          expect(response).to have_http_status(:unauthorized)
        end
      end

      context 'when the store user is logged' do
        let(:user) { create(:user, store:) }
        let(:headers) { create_headers_with_bearer_token(user) }

        it 'creates the given category' do
          expect { post route, params:, headers: }.to change(Category, :count).from(0).to(1)
        end
      end
    end
  end

  describe 'PATCH#update' do
    let(:route) { category_path(category) }
    let(:params) { { name: 'new name', description: 'new description' } }

    context 'the store has a category' do
      let(:store) { create(:store) }
      let(:category) { create(:category, store:) }

      context 'when the user is not logged' do
        it 'has an unauthorized status' do
          patch route, params: params

          expect(response).to have_http_status(:unauthorized)
        end
      end

      context 'when the user is logged' do
        let(:user) { create(:user, store:) }
        let(:headers) { create_headers_with_bearer_token(user) }

        it 'updates the given category' do
          patch route, params: params, headers: headers

          category.reload
          expect(category.name).to eq(params[:name])
          expect(category.description).to eq(params[:description])
        end

        it 'returns the category' do
          patch route, params: params, headers: headers

          expect(response.body).to include(params[:name])
          expect(response.body).to include(params[:description])
        end

        it 'has a success status' do
          patch route, params: params, headers: headers

          expect(response).to have_http_status(:success)
        end

        context 'when the category belongs to different store' do
          let(:category) { create(:category) }
          let(:route) { category_path(category) }

          it 'has an unauthorized status' do
            patch route, params: params, headers: headers

            expect(response).to have_http_status(:unauthorized)
          end
        end
      end
    end
  end

  describe 'DELETE#destroy' do
    context 'when the store has a category' do
      let(:store) { create(:store) }
      let!(:category) { create(:category, store:) }
      let(:route) { category_path(category) }

      context 'when the user is not logged' do
        it 'has an unauthorized status' do
          delete route

          expect(response).to have_http_status(:unauthorized)
        end
      end

      context 'when the user is logged' do
        let(:user) { create(:user, store:) }
        let(:headers) { create_headers_with_bearer_token(user) }

        it 'removes the category' do
          expect do
            delete route, headers:
          end.to change(Category, :count).from(1).to(0)
        end

        context 'when the category belongs to a different store' do
          let(:category) { create(:category) }
          let(:route) { category_path(category) }

          it 'has an unauthorized status' do
            delete route, headers: headers

            expect(response).to have_http_status(:unauthorized)
          end
        end
      end
    end
  end
end
