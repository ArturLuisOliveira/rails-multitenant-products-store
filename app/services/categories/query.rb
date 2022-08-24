# frozen_string_literal: true

module Categories
  class Query
    attr_reader :query

    def initialize
      @query = Category.all
    end

    def by_store(store)
      @query = @query.where(store:)

      self
    end
  end
end
