class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers, allow_destroy: true,
    reject_if: proc {|a| a[:content].blank?}
    
  validates :content, presence: true
  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy
    
  scope :of_category, ->category_id{where category_id: category_id if category_id.present?}
  scope :recent, ->{order "created_at DESC"}
  scope :learned, ->current_user_id{where "id IN (SELECT word_id FROM results 
    WHERE lesson_id IN (SELECT id FROM lessons WHERE user_id = ?))", current_user_id}
  scope :not_learned, ->current_user_id{where "id NOT IN (SELECT word_id FROM results 
    WHERE lesson_id IN (SELECT id FROM lessons WHERE user_id = ?))", current_user_id}
  scope :get_all, ->current_user_id{}
end
