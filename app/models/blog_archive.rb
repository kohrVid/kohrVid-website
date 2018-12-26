class BlogArchive
  attr_accessor :post_date

  def post_date
    date = {}
    Post.all.where(["published_at is not null"]).order("published_at DESC").group_by { |post| post.published_at.year }.sort.reverse.each { |year, e| date[year] = e.group_by { |post| post.published_at.month } }
    return date
  end
end
