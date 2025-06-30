
module Queries
  class BaseFilters
    attr_accessor :base_scope

    def initialize(base_scope)
      @base_scope = base_scope
    end

    def call(params)
      raise NoMethodError, "filtering yet to be implemented"
    end

    def search
      yield(params)
    end

    private

    def search_by_name(name: nil)
      name ? scoped.where(name: name) : scoped
    end

    def paginate(scoped, page_number = 1, per_page = 10)
      offset = (page_number.to_i - 1) * per_page.to_i
      scoped.offset(offset).limit(per_page)
    end
  end
end
