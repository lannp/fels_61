class Result < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :word
  scope :correct_answers, ->{where status: true}
  scope :results_by_user, ->lesson_ids{where "lesson_id IN (?)", lesson_ids}
end
