class EmployerProfile < ApplicationRecord
  belongs_to :user
  has_many :jobs, dependent: :destroy
  
  validates :company_name, presence: true
end