# frozen_string_literal:true

module Categories
  class Finder
    def initialize(id)
      @id = id
    end

    def find
      Category.find(@id)
    end
  end
end
