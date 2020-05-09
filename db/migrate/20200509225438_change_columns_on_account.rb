class ChangeColumnsOnAccount < ActiveRecord::Migration[6.0]
  def change
    change_column_null :accounts, :name, false
    change_column_null :accounts, :amount, false
  end
end
