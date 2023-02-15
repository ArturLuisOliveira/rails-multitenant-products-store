# frozen_string_literal: true

module Items
  class Creator
    def initialize(name:, description:, store:, category:, aditional_info: nil)
      @name = name
      @description = description
      @aditional_info = aditional_info
      @store = store
      @category = category
    end

    def create
      @item = Item.create(
        name: @name,
        description: @description,
        aditional_info: @aditional_info,
        store: @store,
        category: @category
      )

      ActiveRecord::Base.transaction do
        @item.save!

        @item unless @item.nil?
      rescue ActiveRecord::RecordInvalid, ActiveRecord::StatementInvalid, ActiveRecord::RecordNotFound
        false
      end
    end
  end
end
