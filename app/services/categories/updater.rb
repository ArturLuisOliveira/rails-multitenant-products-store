# frozen_string_literal: true

module Categories
  class Updater
    def initialize(category:, params:)
      @category = category
      @params = params
    end

    def update
      ActiveRecord::Base.transaction do
        @category.update!(@params)

        true
      rescue ActiveRecord::RecordInvalid, ActiveRecord::StatementInvalid, ActiveRecord::RecordNotFound
        false
      end
    end
  end
end
