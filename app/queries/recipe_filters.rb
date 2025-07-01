
class RecipeFilters < BaseFilters
  def call
    self.search do
      scoped = search_by_name(base_scope, params[:name])
      scoped = search_by_category(scoped, params[:category_name])
      paginate(scoped, params[:page_number], params[:per_page])
    end
  end

  private

  def search_by_category(scoped, category_name = nil)
    category_name ? scoped.where("category LIKE ?", "%#{category_name}%") : scoped
  end
end
