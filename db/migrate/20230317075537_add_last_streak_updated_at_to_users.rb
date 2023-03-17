class AddLastStreakUpdatedAtToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :last_streak_updated_at, :datetime
  end
end
