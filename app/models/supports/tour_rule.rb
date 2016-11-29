class Supports::TourRule
  def places
    @places ||= Place.all.collect {|place| [place.name, place.id]}
  end

  def conditions
    @conditions ||= Condition.condition_types.collect {|key, value|
      [I18n.t("tour_rule.#{key}"), key]}
  end
end
