class Project < ApplicationRecord
  has_many_attached :attachments

  validates :customer_name, presence: true
  validates :sales_office, presence: true
  validates :sales_representative, presence: true
  validates :request_type, presence: true
  validates :request_content, presence: true
  validates :order_date, presence: true
  validates :due_date, presence: true
  validates :revenue, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :cost, presence: true, numericality: { greater_than_or_equal_to: 0 }

  REQUEST_TYPES = { 新規依頼: 0, 修正依頼: 1, 追加依頼: 2, バグ修正: 3, その他: 4 }
  REQUEST_CONTENTS = { WEBアプリ制作: 0, WEBデザイン制作: 1, スマホアプリ制作: 2, システム構築: 3, データ解析: 4, その他: 5 }

  # クラスメソッドとして定義
  def self.request_types
    REQUEST_TYPES
  end

  def self.request_contents
    REQUEST_CONTENTS
  end

  before_save :calculate_profit

  private

  def calculate_profit
    self.profit = self.revenue.to_i - self.cost.to_i
  end
end