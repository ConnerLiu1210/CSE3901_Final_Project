class Expense < ApplicationRecord
  belongs_to :trip
  belongs_to :payer, class_name: "User", foreign_key: :user_id
  has_many :expense_splits, dependent: :destroy
  has_many :participants, through: :expense_splits, source: :user

  validates :description, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :date, presence: true
  validates :category, inclusion: { in: Trip::CATEGORIES }

  def split_evenly_among(user_ids)
    expense_splits.destroy_all
    share = (amount / user_ids.size).round(2)
    remainder = (amount - share * user_ids.size).round(2)

    user_ids.each_with_index do |uid, idx|
      adjusted = idx == 0 ? share + remainder : share
      expense_splits.create!(user_id: uid, amount: adjusted)
    end
  end
end
