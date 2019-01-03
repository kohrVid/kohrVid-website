class Project < ApplicationRecord
  mount_uploader :image, FileUploader, s3_protocol: :https
  validates :name, presence: true
  validate :publishing_requirements

  REQUIRED_PUBLISHING_ATTRIBUTES = %w(image repo_url languages description)

  private

  def publishing_requirements
    missing_attrs = attributes.select do |k, v|
      (REQUIRED_PUBLISHING_ATTRIBUTES.include? k) && v.present? == false
    end

    if draft == false && missing_attrs.any?
      missing_attrs.each do |attr, _|
        errors.add(attr.to_sym, 'must be present when published')
      end
    end
  end
end
