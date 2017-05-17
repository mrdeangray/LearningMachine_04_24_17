class CreateObjectives < ActiveRecord::Migration[5.0]
  def change
    create_table :objectives do |t|
      t.text :title
      t.datetime :completed_at
      t.string :category
      t.integer :user_id

      t.timestamps
    end
  end
end
