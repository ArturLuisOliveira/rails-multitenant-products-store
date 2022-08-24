# frozen_string_literal: true

module Categories
  class Creator
    def initialize(store:, name:, description:)
      @store = store
      @name = name
      @description = description
    end

    def create
      @category = Category.new(store: @store, name: @name, description: @description)

      ActiveRecord::Base.transaction do
        @category.save!

        true
      rescue ActiveRecord::RecordInvalid, ActiveRecord::StatementInvalid
        false
      end
    end
  end
end
