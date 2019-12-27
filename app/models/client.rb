class Client < ActiveRecord::Base
  mount_uploader :logo, FileUploader, s3_protocol: :https
  mount_uploader :image, FileUploader, s3_protocol: :https
  mount_uploader :pdf, FileUploader, s3_protocol: :https
  validates :name, presence: true
  validates :client_url, presence: true

  scope :drafts, proc { where(draft: true).order("rank ASC") }
  scope :published, proc { where(draft: false).order("rank ASC") }
end
