class Post < ActiveRecord::Base
	
	before_save do
		published
	end

	has_many :tags, through: :post_tags
	has_many :post_tags
	validates :title, presence: true, length: { maximum: 50 }, uniqueness: true
	validates :body, presence: true, length: {minimum: 4, maximum: 20000}, uniqueness: true
#	validates :post_tags, presence: true, associated: true

	def published
		if (self.draft == false) && (self.published_at == nil)
			self.published_at = Time.now
		end
	end
end
