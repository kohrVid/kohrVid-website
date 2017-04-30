class Tag < ActiveRecord::Base
  has_many :post_tags, dependent: :destroy
  has_many :posts, -> { distinct }, through: :post_tags

  validates :name, presence: true, length: { maximum: 15 }, uniqueness: true
  
  def self.tag_relationship(object)
    unless object.tag_list.nil?
      list = object.tag_list.split(",").collect{|i| i.gsub!(/^\s*/, "")}.reject(&:blank?)
      add_tag_relationship(object, list)
      check_tag_relationship(object, list)
      check_for_duplicates(object, list)
    end
  end

  def self.add_tag_relationship(object, list)
    through_table, model_column = handle_through_table(object.class)
    list.each do |tag_name|
      if Tag.find_by(name: tag_name.to_s).nil?
        tag = object.tags.create(name: tag_name.to_s)
      else
        tag = Tag.find_by(name: tag_name.to_s)
        through_table.create!(
          model_column => object.id, tag_id: tag.id
        )
      end
    end
  end

  def self.check_tag_relationship(object, list)
    through_table, model_column = handle_through_table(object.class)
    relationships = through_table.where(model_column => object.id)
    relationships.each do |row|
      unless list.include? Tag.find(row.tag_id).name
        row.destroy!
      end
    end
  end

  def self.check_for_duplicates(object, list)
    through_table, model_column = handle_through_table(object.class)
    list.each do |tag_name|
      relationships = through_table.where(
        model_column => object.id,
        tag_id: Tag.find_by(name: tag_name.to_s).id
      ).order(:created_at)
      unless relationships.count <= 1
        relationships.all[1..-1].each do |duplicate|
          duplicate.destroy!
        end
      end
    end
  end

  def self.handle_through_table(model)
    ["#{ model }Tag".constantize, "#{ model.name.underscore }_id"]
  end
end
