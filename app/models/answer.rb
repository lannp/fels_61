class Answer < ActiveRecord::Base
  belongs_to :word
  validates :content, presence: true
end
