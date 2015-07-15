class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :title
      t.text :content
      t.integer :category, default: 0
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
