class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { wait: 0, confirm: 1, make: 2, radytoship: 3, shipped: 4}
  belongs_to :customer
  has_many :order_details
end
