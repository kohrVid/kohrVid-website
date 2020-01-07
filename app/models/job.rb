class Job < ApplicationRecord
  validates :title, presence: true
  validates :company_name, presence: true
  validates :company_website, presence: true
  validates :start_date, presence: true
  validates :description, presence: true
  validate :start_date_is_in_the_past

  def start_date_is_in_the_past
    if self.start_date.present? && self.start_date > Time.now
      errors[:start_date] << "must be in the past"
    end
  end
end
