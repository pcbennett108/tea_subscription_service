class Subscription < ApplicationRecord
  validates :title, presence: true
  validates :price, presence: true
  validates :frequency, presence: true
  validates :customer_id, presence: true
  validates :tea_id, presence: true
  validates :sub_status, presence: true
  belongs_to :customer
  belongs_to :tea

  enum :sub_status,["Cancelled", "Subscribed"]
end