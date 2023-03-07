# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  nickname   :string           default(""), not null
#  provider   :string           default(""), not null
#  uid        :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_nickname  (nickname) UNIQUE
#
class User < ApplicationRecord
  has_many :contributions
  has_many :mountains, through: :contributions

  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]

    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.nickname = auth[:info][:nickname]
    end
  end
end
