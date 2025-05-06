class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 🔹 必須項目のバリデーション
  validates :employee_id, presence: true, uniqueness: true
  validates :user_name, presence: true
  validates :department, presence: true # 🔹 `NULL` にならないようにする
end