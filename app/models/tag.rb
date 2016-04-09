class Tag < ActiveRecord::Base
	has_many :posts, -> { uniq }, through: :post_tags
	has_many :post_tags, dependent: :destroy

	validates :name, presence: true, length: { maximum: 15 },
	  			uniqueness: true
end
