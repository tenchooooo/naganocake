class OrderDetail < ApplicationRecord
  enum making_status: { donotmade: 0, wait: 1, maid: 2, finish: 3}
  belongs_to :order
  belongs_to :item

end
