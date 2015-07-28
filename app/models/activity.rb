class Activity < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true 
  validates :content, presence: true
  validates :content_id, presence: true
  scope :recent, ->{order "created_at DESC"}
  
  def type
    content == Settings.learned ? Lesson.find(content_id) : User.find(user_id)  
  end
end
