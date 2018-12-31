class Post < ActiveRecord::Base
  before_save :publish
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged]

  has_many :post_tags, dependent: :destroy
  has_many :tags, -> { distinct }, through: :post_tags
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :body, presence: true,
    length: { minimum: 4, maximum: 20000 }, uniqueness: true
#	validates :post_tags, presence: true, associated: true

  scope :drafts, proc { where(draft: true) }
  scope :published, proc { where(draft: false).order("published_at DESC") }


  def slug_candidates
    [
      :title,
      [:title, :id]
    ]
  end

  def publish
    if (self.draft == false) && (self.published_at == nil)
      self.published_at = Time.now
    end
  end

  def self.post_date
    date = {}
    Post.all.where(["published_at is not null"]).order("published_at DESC").group_by { |post| post.published_at.year }.sort.reverse.each { |year, e| date[year] = e.group_by { |post| post.published_at.month } }
    return date
  end
end
