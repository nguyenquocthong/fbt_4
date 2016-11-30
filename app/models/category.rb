class Category < ActsAsTaggableOn::Tag
  scope :order_count, -> {order taggings_count: :desc}
end
