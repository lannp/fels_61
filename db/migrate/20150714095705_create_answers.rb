class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :conttent
      t.boolean :status
      t.references :word

      t.timestamps null: false
    end
  end
end
