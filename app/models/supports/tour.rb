class Supports::Tour
  def places
    @places = Place.all
  end

  def categories
    @categories = Category.order_count.limit Settings.limit_category
  end
end
