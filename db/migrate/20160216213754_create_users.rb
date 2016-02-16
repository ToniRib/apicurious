class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :token
      t.string :uid
      t.string :full_name
      t.string :display_name
      t.string :avatar

      t.timestamps null: false
    end
  end
end
