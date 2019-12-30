class Tag < ActiveRecord::Base
  has_many :post_tags, dependent: :destroy
  has_many :posts, -> { distinct }, through: :post_tags

  validates :name, presence: true, length: { maximum: 15 }, uniqueness: true


  # Note, the class methods are quite generic as the `tags` table could
  # theoretically be associated with other tables in the future 
  def self.tag_relationship(object)
    unless object.tag_list.blank?
      tag_list = clean_tag_names_list(object.tag_list)
      current_tag_relationships = add_tag_relationships(object, tag_list)
      remove_old_tag_relationships(object, current_tag_relationships)
    end
  end

  def self.add_tag_relationships(object, tag_list)
    through_table, column = handle_through_table(object.class)
    current_tag_relationships = []

    tag_list.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name)
      
      tag_relationship = through_table.find_or_create_by(
        column => object.id, tag_id: tag.id
      )
      
      current_tag_relationships << tag_relationship
    end

    current_tag_relationships
  end

  def self.remove_old_tag_relationships(object, current_tag_relationships)
    through_table, column = handle_through_table(object.class)
    old_relationships = through_table.where(column => object.id)

    (old_relationships - current_tag_relationships).map(&:destroy!)
  end

  def self.handle_through_table(klass)
    ["#{ klass }Tag".constantize, "#{ klass.name.underscore }_id"]
  end

  def self.clean_tag_names_list(tag_names)
    tag_names.downcase.split(",")
      .collect { |i| i.gsub!(/^\s*/, "") }
      .reject(&:blank?)
      .map(&:to_s)
  end
end
