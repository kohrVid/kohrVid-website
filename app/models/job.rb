class Job < ApplicationRecord
  validates :title, presence: true
  validates :company_name, presence: true
  validates :company_website, presence: true
  validates :start_date, presence: true
  validates :description, presence: true
  validate :start_date_is_in_the_past

  has_rich_text :description

  def start_date_is_in_the_past
    if self.start_date.present? && self.start_date > Time.now
      errors[:start_date] << "must be in the past"
    end
  end

  def format_end_date
    if end_date.present? && end_date.past?
      end_date.strftime("%b %Y")
    else
      "Present"
    end
  end
end
