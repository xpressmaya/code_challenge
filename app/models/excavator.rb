class Excavator < ApplicationRecord
  belongs_to :ticket
  
  validates :company_name, presence: true
  validates :address, presence: true
  validates :crew_onsite, presence: true
end
