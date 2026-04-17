class User < ApplicationRecord
  has_secure_password
  
  enum role: { candidate: 0, employer: 1, admin: 2 }
  
  has_one :candidate_profile, dependent: :destroy
  has_one :employer_profile, dependent: :destroy
  
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: -> { password.present? }
  
  after_create :create_profile
  
  private
  
  def create_profile
    if candidate?
      create_candidate_profile
    elsif employer?
      create_employer_profile
    end
  end
end