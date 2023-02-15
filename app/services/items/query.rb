# fronzen_string_literal: true

module Items
  class Query
    attr_reader :query

    def initialize(query: nil)
      @query = query || Item.all
    end

    def by_store(store)
      @query = @query.where(store:)

      self
    end

    def by_category(category)
      @query = @query.where(category:) unless category.nil?

      self
    end
  end
end
