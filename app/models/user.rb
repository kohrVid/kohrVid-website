class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable
	has_many :comments
	

	validates :name,  	presence: true,
				length: {maximum: 50}
	validates :email, 	presence: true,
				length: {maximum: 255},
				uniqueness: {case_sensitive: false}
	validates :password, 	presence: true,
				length: {minimum: 6},
				allow_nil: true
	

	def locked?
		return true unless self.locked_at == nil
	end

	def admin?
		return true if self.admin == true
	end

end
