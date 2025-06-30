
module Queries
  class UserFilters < BaseFilters
    def call(params)
      self.search do |query|
        scoped = search_by_name(params[:name])
        paginate(scoped, params[:page_number], params[:per_page])
      end
    end
  end
end
