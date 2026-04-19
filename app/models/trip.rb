class Trip < ApplicationRecord
  include TripCalculations

  has_many :participants, dependent: :destroy
  has_many :users, through: :participants
  has_many :expenses, dependent: :destroy

  CATEGORIES = ["General", "Gas", "Lodging", "Food", "Entertainment", "Other"].freeze

  validates :trip_name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    return unless start_date && end_date
    errors.add(:end_date, "must be on or after start date") if end_date < start_date
  end
end
