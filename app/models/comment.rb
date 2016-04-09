class Comment < ActiveRecord::Base
	acts_as_tree order: "created_at ASC"
	belongs_to :user, foreign_key: "user_id"
	belongs_to :post, foreign_key: "post_id"

	validates :body, presence: true
	validates :post_id, presence: true
		
	def author
		if self.user_id.present?
			return User.find(self.user_id).name
		else
			return "Anonymous"
		end
	end

end
