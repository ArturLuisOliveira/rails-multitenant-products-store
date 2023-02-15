# frozen_string_literal: true

module Items
  class Finder
    def initialize(id)
      @id = id
    end

    def find
      Item.find(@id)
    end
  end
end
