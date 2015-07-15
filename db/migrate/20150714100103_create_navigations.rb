class CreateNavigations < ActiveRecord::Migration
  def change
    create_table :navigations do |t|
      t.string :session
      t.references :user, index: true
      t.references :card, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
