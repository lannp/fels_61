class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :results, dependent: :destroy
  has_many :words, through: :results
  accepts_nested_attributes_for :results
  before_create :create_default
  
  private
  def create_default
    Category.find(self.category_id).words.
      order("RANDOM()").limit(Settings.words_per_lesson).each do |word|
        self.results.build word_id: word.id, status: false 
    end
  end
end
