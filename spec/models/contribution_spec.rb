# == Schema Information
#
# Table name: contributions
#
#  id                  :bigint           not null, primary key
#  contribution_number :integer          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  mountain_id         :bigint
#  user_id             :bigint
#
# Indexes
#
#  index_contributions_on_mountain_id  (mountain_id)
#  index_contributions_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (mountain_id => mountains.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Contribution, type: :model do
  describe 'validations' do
    subject { Contribution.new(contribution_number: 100) }

    context 'when contribution_number is present' do
      it 'is valid' do
        expect(subject).to be_valid
      end
    end

    context 'when contribution_number is nil' do
      before { subject.contribution_number = nil }

      it 'is not valid' do
        expect(subject).to_not be_valid
      end
    end
  end

  describe 'associations' do
    let(:contribution) { Contribution.new }
    let(:mountain) { Mountain.new }
    let(:user) { User.new }

    it 'can belong to a mountain' do
      contribution.mountain = mountain
      expect(contribution.mountain).to eq(mountain)
    end

    it 'can belong to a user' do
      contribution.user = user
      expect(contribution.user).to eq(user)
    end
  end
end
