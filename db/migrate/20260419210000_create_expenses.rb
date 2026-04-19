class CreateExpenses < ActiveRecord::Migration[7.1]
  def change
    create_table :expenses, force: :cascade do |t|
      t.string :description, null: false
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.date :date, null: false
      t.string :category, default: "General"
      t.references :trip, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
