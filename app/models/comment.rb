class Comment < ActiveRecord::Base
	acts_as_tree order: "created_at ASC"
	belongs_to :user, foreign_key: "user_id"
	belongs_to :post, foreign_key: "post_id"
#	attr_reader :post_id
end
