class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :name
      t.integer :score
      t.references :user
      t.references :category

      t.timestamps null: false
    end
  end
end
