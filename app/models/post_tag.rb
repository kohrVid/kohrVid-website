class PostTag < ActiveRecord::Base
	belongs_to :posts
	belongs_to :tags

	validates :post_id, presence: true
	validates :tag_id, presence: true
	
end
