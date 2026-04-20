module TripCalculations
  extend ActiveSupport::Concern

  def total_paid_by(user)
    expenses.where(user_id: user.id).sum(:amount)
  end

  def total_owed_by(user)
    ExpenseSplit.joins(:expense)
                .where(expenses: { trip_id: id }, user_id: user.id)
                .sum(:amount)
  end

  def net_balance(user)
    total_paid_by(user) - total_owed_by(user)
  end

  def settlements
    balances = users.map { |u| [ u, net_balance(u).to_f ] }.to_h

    debtors   = balances.select { |_, b| b < -0.001 }.map { |u, b| [ u, b.abs ] }.sort_by { |_, b| -b }
    creditors = balances.select { |_, b| b >  0.001 }.map { |u, b| [ u, b ]     }.sort_by { |_, b| -b }

    transactions = []
    i = j = 0

    while i < debtors.length && j < creditors.length
      debtor,   debt   = debtors[i]
      creditor, credit = creditors[j]

      amount = [ debt, credit ].min.round(2)
      transactions << { from: debtor, to: creditor, amount: amount }

      debtors[i][1]   = (debt   - amount).round(2)
      creditors[j][1] = (credit - amount).round(2)

      i += 1 if debtors[i][1] <= 0.001
      j += 1 if creditors[j][1] <= 0.001
    end

    transactions
  end
end
