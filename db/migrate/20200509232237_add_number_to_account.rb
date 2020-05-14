class AddNumberToAccount < ActiveRecord::Migration[6.0]
  def change
    change_table :accounts, bulk: true do |t|
      t.integer :number
      t.index :number, unique: true
      t.string :token, null: false, default: ''
      t.index :token
    end
  end
end
