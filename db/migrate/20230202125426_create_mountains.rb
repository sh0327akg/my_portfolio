class CreateMountains < ActiveRecord::Migration[7.0]
  def change
    create_table :mountains do |t|
      t.string  :kana
      t.string  :name
      t.string  :prefecture
      t.integer :elevation, index: true
      t.float   :latitude
      t.float   :longitude

      t.timestamps
    end
  end
end
