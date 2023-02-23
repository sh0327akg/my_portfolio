class CreateContributions < ActiveRecord::Migration[7.0]
  def change
    create_table :contributions do |t|
      t.integer    :contribution_number, null: false
      t.references :mountain,            foreign_key: true

      t.timestamps
    end
  end
end
