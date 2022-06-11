class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items
  attachment :image

  def get_image
    image
  end
end
