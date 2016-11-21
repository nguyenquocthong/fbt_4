class Supports::AdminTour
  def initialize
  end

  def load_discounts
    @discounts = Discount.all.map{|discount| [discount.title, discount.id]}
  end

  def load_places
    @places = Place.all.map{|place| [place.name, place.id]}
  end

  def load_active_types
    @active_types = Tour.is_actives.collect{|key, value|
      [I18n.t("view.active_type.#{key}"), key]}
  end
end
