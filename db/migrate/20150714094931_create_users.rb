class CreateUsers < ActiveRecord::Migration

  def change
    enable_extension :hstore
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.boolean :admin,                 default: false
      t.string :password_reset_token
      t.hstore :credentials
      t.timestamps null: false
    end
  end

end
