# frozen_string_literal: true

module Items
  class Updater
    def initialize(item:, params:)
      @item = item
      @params = params
    end

    def update
      ActiveRecord::Base.transaction do
        @item.update!(@params)

        true
      rescue ActiveRecord::RecordInvalid, ActiveRecord::StatementInvalid, ActiveRecord::RecordNotFound
        false
      end
    end
  end
end
