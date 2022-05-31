class Item < ApplicationRecord
  belongs_to :genre
  attachment :image
  
  def get_image
    image
  end
end
