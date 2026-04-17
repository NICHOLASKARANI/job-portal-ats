class Job < ApplicationRecord
  belongs_to :employer_profile
  has_many :applications, dependent: :destroy
  
  enum status: { draft: 0, published: 1, closed: 2, archived: 3 }
  enum employment_type: { full_time: 0, part_time: 1, contract: 2, internship: 3, remote: 4 }
  
  validates :title, :description, :requirements, :location, presence: true
  
  scope :active, -> { where(status: :published).where('expiry_date > ?', Date.current) }
  scope :recent, -> { order(created_at: :desc) }
  
  include PgSearch::Model
  pg_search_scope :search_jobs,
    against: [:title, :description, :requirements, :location],
    using: {
      tsearch: { prefix: true }
    }
  
  def days_remaining
    (expiry_date - Date.current).to_i if expiry_date
  end
ends