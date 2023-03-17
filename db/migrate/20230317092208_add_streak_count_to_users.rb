class AddStreakCountToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :streak_count, :integer, default: 0
  end
end
