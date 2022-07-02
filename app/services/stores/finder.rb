# frozen_string_literal: true

module Stores
  class Finder
    def initialize(id)
      @id = id
    end

    def find
      Store.find(@id)
    end
  end
end
