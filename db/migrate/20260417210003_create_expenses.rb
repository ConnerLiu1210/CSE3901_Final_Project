class CreateExpenses < ActiveRecord::Migration[7.1]
  def change
    create_table :expenses do |t|
      t.string :description, null: false
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.date :date, null: false
      t.string :category, default: "General"
      t.integer :trip_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
    add_index :expenses, :trip_id
    add_index :expenses, :user_id
  end
end
