
class BaseFilters
  attr_accessor :base_scope, :params

  def initialize(base_scope, params)
    @base_scope = base_scope
    @params = params
  end

  def call
    raise NoMethodError, "filtering yet to be implemented"
  end

  def search
    yield
  end

  private

  def search_by_name(scoped, name = nil)
    name ? scoped.where("name LIKE ?", "%#{name}%") : scoped
  end

  def paginate(scoped, page_number = 1, per_page = 10)
    offset = (page_number.to_i - 1) * per_page.to_i
    scoped.offset(offset).limit(per_page)
  end
end
