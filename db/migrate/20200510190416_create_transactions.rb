class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.integer :amount
      t.references :account_source, null: false
      t.references :account_destination, null: false

      t.timestamps
    end
  end
end
