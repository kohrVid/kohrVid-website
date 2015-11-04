class Client < ActiveRecord::Base
	mount_uploader :logo_url, FileUploader
	mount_uploader :image_url, FileUploader
	mount_uploader :pdf, FileUploader
	validates :client_name, presence: true
	validates :client_url, presence: true

end
