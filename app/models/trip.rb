class Trip < ApplicationRecord
  # Trip contains (or was participated by) many users
  has_many :participants, dependent: :destroy
  has_many :users, through: :participants

  # Trip has many expenses
  # has_many :expense, dependent: :destroy

  # Validations
end
