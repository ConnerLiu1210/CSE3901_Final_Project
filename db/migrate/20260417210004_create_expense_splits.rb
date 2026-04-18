class CreateExpenseSplits < ActiveRecord::Migration[7.1]
  def change
    create_table :expense_splits do |t|
      t.integer :expense_id, null: false
      t.integer :user_id, null: false
      t.decimal :amount, precision: 10, scale: 2, null: false

      t.timestamps
    end
    add_index :expense_splits, [:expense_id, :user_id], unique: true
  end
end
