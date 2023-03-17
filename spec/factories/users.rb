# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  last_streak_updated_at :datetime
#  nickname               :string           default(""), not null
#  provider               :string           default(""), not null
#  uid                    :string           default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_nickname  (nickname) UNIQUE
#
FactoryBot.define do
  factory :user do
    provider { "MyString" }
    uid { "MyString" }
    nickname { "MyString" }
  end
end
