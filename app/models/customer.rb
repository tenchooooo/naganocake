class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :cart_items
  has_many :orders

  def full_name
    last_name + "　" + first_name
  end

  def full_name_kana
    last_name_kana + "  " + first_name_kana
  end
end
