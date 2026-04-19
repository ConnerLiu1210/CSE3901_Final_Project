class Trip < ApplicationRecord
  belongs_to :user
  # has_many :expense, dependent: :destroy

  # validations
  
end
