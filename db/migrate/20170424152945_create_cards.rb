class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.text :question
      t.text :answer
      t.text :media
      t.text :comment
      t.integer :rep
      t.text :level
      t.text :category
      t.integer :user_id

      t.timestamps
    end
  end
end
