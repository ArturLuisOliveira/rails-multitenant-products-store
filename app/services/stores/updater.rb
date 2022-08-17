# frozen_string_literal: true

module Stores
  class Updater
    def initialize(store, params)
      @store = store
      @params = params
    end

    def update
      @store.update(@params)
    end
  end
end
