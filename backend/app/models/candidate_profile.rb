class CandidateProfile < ApplicationRecord
  belongs_to :user
  has_many :applications, dependent: :destroy
  
  validates :full_name, presence: true
end