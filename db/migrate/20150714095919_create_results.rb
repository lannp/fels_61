class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.boolean :status
      t.references :word
      t.references :lesson

      t.timestamps null: false
    end
  end
end
