class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.string  :customer_name, null: false
      t.string  :sales_office
      t.string  :sales_representative
      t.integer :request_type, null: false, default: 0 # ENUM管理（新規/修正/追加/バグ修正など）
      t.integer :request_content, null: false, default: 0 # ENUM管理（WEBアプリ制作など）
      t.date    :order_date
      t.date    :due_date
      t.integer :revenue, default: 0 # 売上（1000単位）
      t.integer :cost, default: 0 # コスト（1000単位）
      t.integer :profit # 売上 - コスト（自動計算）
      t.text    :remarks
      t.string  :attachments # 添付資料（Excel, Word, PNG, PDFなど）
      t.references :user, null: false # 社員ID（usersテーブルの外部キー）
      t.string  :assigned_person # 担当者（社員ID入力時に自動入力）

      # 各部門の作業開始・完了日
      t.date    :planning_start_date
      t.date    :planning_end_date
      t.date    :design_start_date
      t.date    :design_end_date
      t.date    :development_start_date
      t.date    :development_end_date

      # 状態管理（0:未着手, 1:進行中, 2:完了）
      t.integer :status, default: 0
      
      t.timestamps
    end
  end
end