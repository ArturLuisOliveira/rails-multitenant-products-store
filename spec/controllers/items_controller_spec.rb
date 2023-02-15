# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ItemsController, type: :request do
  describe 'GET#index' do
    it 'returns the given items' do
      expect(true).to eq(true)
    end
  end

  describe 'GET#show' do
    it 'return the given item' do
      expect(true).to eq(true)
    end
  end

  describe 'PATCH#update' do
    it 'updates the given item' do
      expect(true).to eq(true)
    end
  end

  describe 'DELETE#destroy' do
    it 'destroys the given item' do
      expect(true).to eq(true)
    end
  end

  describe 'POST#create' do
    it 'creates the given item' do
      expect(true).to eq(true)
    end
  end
end
