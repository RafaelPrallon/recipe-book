
class UserFilters < BaseFilters
  def call
    self.search do
      scoped = search_by_name(scoped, params[:name])
      paginate(scoped, params[:page_number], params[:per_page])
    end
  end
end
