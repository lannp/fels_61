class Category < ActiveRecord::Base 
  has_many :lessons, dependent: :destroy
  has_many :words, dependent: :destroy 
  scope :ordered_by_create_at, -> {order "created_at DESC"}
  validates :name, presence: true, length: {maximum: Settings.maximum_category_name_length}
end
