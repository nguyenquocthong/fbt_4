module RatingForHelper
  def rating_for_user rateable_obj, rating_user, dimension = nil, options = {}
    @object = rateable_obj
    @user = rating_user
    @rating = Rate.find_by rater: @user, rateable: @object,
      dimension: dimension
    stars = @rating ? @rating.stars : Settings.rate_min

    star = options[:star] || Settings.rate_max
    enable_half = options[:enable_half] || false
    half_show = options[:half_show] || true
    star_path = options[:star_path] || ""
    star_on = options[:star_on] || asset_path("star-on.png")
    star_off = options[:star_off] || asset_path("star-off.png")
    star_half = options[:star_half] || asset_path("star-half.png")
    cancel = options[:cancel] || false
    cancel_place = options[:cancel_place] || t("ratyrate.left")
    cancel_hint = options[:cancel_hint] || t("ratyrate.cancel_hint")
    cancel_on = options[:cancel_on] || asset_path("cancel-on.png")
    cancel_off = options[:cancel_off] || asset_path("cancel-off.png")
    noRatedMsg = options[:noRatedMsg] || t("ratyrate.noRateMsg")
    space = options[:space] || false
    single = options[:single] || false
    target = options[:target] || ""
    targetText = options[:targetText] || ""
    targetType = options[:targetType] || t("ratyrate.hint")
    targetFormat = options[:targetFormat] || t("ratyrate.targetFormat")
    targetScore = options[:targetScore] || ""
    readonly = options[:readonly] || false

    disable_after_rate = options[:disable_after_rate] || false

    readonly = if options[:readonly]
      options[:readonly]
    elsif disable_after_rate
      current_user.present? ? !rateable_obj.can_rate?(current_user, dimension) : false
    else
      false
    end

    content_tag :div, "", class: "star", data: {dimension: dimension,
      rating: stars, id: rateable_obj.id, classname: rateable_obj.class.name,
      disable_after_rate: disable_after_rate, readonly: readonly,
      enable_half: enable_half, half_show: half_show, star_count: star,
      star_path: star_path, star_on: star_on, star_off: star_off,
      star_half: star_half, cancel: cancel, cancel_place: cancel_place,
      cancel_hint: cancel_hint, cancel_on: cancel_on, cancel_off: cancel_off,
      no_rated_message: noRatedMsg, space: space, single: single,
      target: target, target_text: targetText, target_type: targetType,
      target_format: targetFormat, target_score: targetScore}
  end
end
