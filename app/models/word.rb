class Word < ActiveRecord::Base
  scope :of_category, ->category_id{where category_id: category_id if category_id.present?}
  scope :recent, ->{order "created_at DESC"}
  scope :learned, ->current_user_id{where "id IN (SELECT word_id FROM results 
    WHERE lesson_id IN (SELECT id FROM lessons WHERE user_id = ?))", current_user_id}
  scope :not_learned, ->current_user_id{where "id NOT IN (SELECT word_id FROM results 
    WHERE lesson_id IN (SELECT id FROM lessons WHERE user_id = ?))", current_user_id}
  scope :get_all, ->current_user_id{}
end
