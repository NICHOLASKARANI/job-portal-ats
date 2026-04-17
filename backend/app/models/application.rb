class Application < ApplicationRecord
  belongs_to :job
  belongs_to :candidate_profile
  
  has_one_attached :resume
  
  enum status: { pending: 0, reviewed: 1, shortlisted: 2, interview: 3, offered: 4, hired: 5, rejected: 6 }
  
  validates :cover_letter, presence: true
  validates :resume, attached: true
  
  after_create :send_application_confirmation
  after_update :send_status_notification, if: :saved_change_to_status?
  
  private
  
  def send_application_confirmation
    ApplicationMailer.confirmation(self).deliver_later
  end
  
  def send_status_notification
    ApplicationMailer.status_update(self).deliver_later
  end
end