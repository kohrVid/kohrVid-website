class Post < ActiveRecord::Base
  before_save :publish
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged]

  has_many :post_tags, dependent: :destroy
  has_many :tags, -> { distinct }, through: :post_tags
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { maximum: 75 }, uniqueness: true
  validates :body, length: { maximum: 20000 }
  validates :rich_text_body, presence: true,
    length: { minimum: 14 }, uniqueness: true
#	validates :post_tags, presence: true, associated: true

  #validate :rich_text_body_is_unique

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

  def published_format
    published_at.strftime(
      "Published %e#{published_at.day.ordinal} %B %Y at %I:%M%P %Z"
    ) if published_at.present?
  end

  def updated_format
    updated_at.strftime(
      "(Last Updated %e#{updated_at.day.ordinal} %B %Y at %I:%M%P %Z)"
    ) if published_at.present? && (published_at.to_date != updated_at.to_date)
  end

  def self.post_date
    date = {}

    Post.published.group_by { |post| post.published_at.year }
      .sort.reverse.each do |year, e|
        date[year] = e.group_by { |post| post.published_at.month }
      end
    return date
  end

  def tag_names
    tags.map(&:name)
  end

=begin
  def rich_text_body_is_unique
    current_rich_text_body =
      ActionText::Content.new(rich_text_body.try(:body).try(:to_html))

    if ActionText::RichText.where(body: current_rich_text_body)
      .where('id != ?', id).any?
      errors[:rich_text_body] << "must be unique"
    end
  end
=end
end
