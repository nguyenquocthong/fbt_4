class Supports::CommentSupport
  attr_reader :commented

  def initialize commented
    @commented = commented
  end

  def load_commented
    @commented
  end

  def load_review
    @review = load_commented.review
  end
end
