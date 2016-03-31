class Tag < ActiveRecord::Base
	has_many :posts, through: :post_tags
	has_many :post_tags

	validates :name, presence: true, length: { maximum: 15 },
	  			uniqueness: true
end
