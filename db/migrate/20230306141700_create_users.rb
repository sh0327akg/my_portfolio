class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :nickname

      t.timestamps
    end
  end
end
