class AddSlugToCards < ActiveRecord::Migration
  def change
    add_column :cards, :slug, :string
    add_index :cards, :slug
  end
end
