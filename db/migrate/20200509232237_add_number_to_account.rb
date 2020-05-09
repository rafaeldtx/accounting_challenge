class AddNumberToAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :number, :integer
    add_index :accounts, :number, unique: true
    add_column :accounts, :token, :string, null: false
    add_index :accounts, :token, unique: true
  end
end
