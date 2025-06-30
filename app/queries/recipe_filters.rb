
module Queries
  class RecipeFilters < BaseFilters
    def call(params)
      self.search do |query|
        scoped = search_by_name(params[:name])
        scoped = scoped.search_by_category(params[:category_name])
        paginate(scoped, params[:page_number], params[:per_page])
      end
    end

    private

    def search_by_category(category_name = nil)
      category_name ? scoped.joins(:categories).where(category: { name: category_name }) : scoped
    end
  end
end
