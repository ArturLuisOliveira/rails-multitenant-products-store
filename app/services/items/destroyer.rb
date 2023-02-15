module Items
  class Destroyer
    def initialize(item)
      @item = item
    end

    def destroy
      ActiveRecord::Base.transaction do
        @item.destroy

        true
      rescue ActiveRecord::RecordInvalid, ActiveRecord::StatementInvalid, ActiveRecord::RecordNotFound
        false
      end
    end
  end
end
