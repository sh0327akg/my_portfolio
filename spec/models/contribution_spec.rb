# == Schema Information
#
# Table name: contributions
#
#  id                  :bigint           not null, primary key
#  contribution_number :integer          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  mountain_id         :bigint
#
# Indexes
#
#  index_contributions_on_mountain_id  (mountain_id)
#
# Foreign Keys
#
#  fk_rails_...  (mountain_id => mountains.id)
#
require 'rails_helper'

RSpec.describe Contribution, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
