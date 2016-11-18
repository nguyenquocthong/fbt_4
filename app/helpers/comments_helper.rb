module CommentsHelper
  def comments_tree_for comments, review
    comments.map do |comment, nested_comments|
      render(comment, review: review) + (nested_comments.size > 0 ?
        content_tag(:div, comments_tree_for(nested_comments, review),
        class: "replies") : nil)
    end.join.html_safe
  end
end
