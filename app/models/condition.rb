class Condition < ApplicationRecord
  belongs_to :tour_rule
  validate :list_id_input

  enum condition_type: [:price_less, :price_more, :place, :tour]

  private
  def list_id_input
    if place? || tour?
      condition_value.split(",").each{|e|
        errors.add :base, I18n.t("tour_rule.list_id_error") unless e =~ /\d+/
      }
    end
  end
end
