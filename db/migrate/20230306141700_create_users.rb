class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :provider, null: false, default: ""
      t.string :uid,      null: false, default: ""
      t.string :nickname, null: false, default: ""

      t.timestamps
    end

    add_index :users, :nickname, unique: true
  end
end
