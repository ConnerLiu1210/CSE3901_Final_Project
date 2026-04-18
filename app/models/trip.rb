class Trip < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: :user_id
  has_many :trip_memberships, dependent: :destroy
  has_many :members, through: :trip_memberships, source: :user
  has_many :expenses, dependent: :destroy

  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_after_start_date

  CATEGORIES = ["General", "Gas", "Lodging", "Food", "Entertainment", "Other"].freeze

  # Total amount paid by a participant (expenses they covered)
  def total_paid_by(user)
    expenses.where(user_id: user.id).sum(:amount)
  end

  # Total amount owed by a participant (their share across all expenses)
  def total_owed_by(user)
    ExpenseSplit.joins(:expense)
                .where(expenses: { trip_id: id }, user_id: user.id)
                .sum(:amount)
  end

  # Positive = is owed money; negative = owes money
  def net_balance(user)
    total_paid_by(user) - total_owed_by(user)
  end

  # Greedy algorithm: returns array of { from:, to:, amount: }
  def settlements
    balances = members.map { |u| [u, net_balance(u).to_f] }.to_h

    debtors   = balances.select { |_, b| b < -0.001 }.map { |u, b| [u, b.abs] }.sort_by { |_, b| -b }
    creditors = balances.select { |_, b| b >  0.001 }.map { |u, b| [u, b]     }.sort_by { |_, b| -b }

    transactions = []
    i = j = 0

    while i < debtors.length && j < creditors.length
      debtor,   debt   = debtors[i]
      creditor, credit = creditors[j]

      amount = [debt, credit].min.round(2)
      transactions << { from: debtor, to: creditor, amount: amount }

      debtors[i][1]   = (debt   - amount).round(2)
      creditors[j][1] = (credit - amount).round(2)

      i += 1 if debtors[i][1] <= 0.001
      j += 1 if creditors[j][1] <= 0.001
    end

    transactions
  end

  private

  def end_date_after_start_date
    return unless start_date && end_date
    errors.add(:end_date, "must be on or after start date") if end_date < start_date
  end
end
