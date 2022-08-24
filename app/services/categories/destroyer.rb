# frozen_string_literal:true

module Categories
  class Destroyer
    def initialize(id)
      @id = id
    end

    def destroy
      ActiveRecord::Base.transaction do
        Category.destroy(@id)

        true
      rescue ActiveRecord::RecordInvalid, ActiveRecord::StatementInvalid, ActiveRecord::RecordNotFound
        false
      end
    end
  end
end
