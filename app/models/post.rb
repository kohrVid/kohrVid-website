class Post < ActiveRecord::Base
  before_save do
    published
  end
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged]
  has_many :tags, -> { uniq }, through: :post_tags
  has_many :post_tags, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :body, presence: true, length: { minimum: 4, maximum: 20000 }, uniqueness: true
#	validates :post_tags, presence: true, associated: true

  
  def slug_candidates
    [
      :title,
      [:title, :id]
    ]
  end

  def published
    if (self.draft == false) && (self.published_at == nil)
      self.published_at = Time.now
    end
  end

  def self.post_date
    date = {}
    Post.all.where(["published_at is not null"]).order("published_at DESC").group_by { |post| post.published_at.year }.sort.reverse.each { |year, e| date[year] = e.group_by { |post| post.published_at.month } }
    return date
  end

  
  def tag_relationship(post_record, list)
    unless list.nil?
      split_tags(list)
      add_tag_relationship(post_record)
      check_tag_relationship(post_record)
      check_for_duplicates(post_record)
    end
  end

  def split_tags(text)
    @list = text.split(",").collect{|i| i.gsub!(/^\s*/, "")}.reject(&:blank?)
  end

  def add_tag_relationship(model)
    @list.each do |item|
      if Tag.find_by(name: item.to_s).nil?
        tag = Tag.create!(name: item.to_s)
      else
        tag = Tag.find_by(name: item.to_s)
      end
      PostTag.create!(post_id: model.id, tag_id: tag.id)
    end
  end

  def check_for_duplicates(model)
    @list.each do |item|
      instance = PostTag.where(
        post_id: model.id,
        tag_id: Tag.find_by(name: item.to_s).id
      ).order(:created_at)
      unless instance.count <= 1
        instance.all[1..-1].each do |duplicate|
          duplicate.destroy!
        end
      end
    end
  end

  def check_tag_relationship(model)
    relationships = PostTag.all.where(post_id: model.id)
    relationships.each do |row|
      unless @list.include? Tag.find(row.tag_id).name
        row.destroy
      end
    end
  end
end
