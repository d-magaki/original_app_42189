class AddEmailToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :email, :string, null: false, default: ""
    add_index :users, :email, unique: true # 🔹 ユニーク制約を再追加
  end
end