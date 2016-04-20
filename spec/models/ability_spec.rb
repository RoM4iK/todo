require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  describe 'user' do
    let(:user) { FactoryGirl.create(:user, email: "user@gmail.com") }
    let(:other_user) { FactoryGirl.create(:user, email: "other@gmail.com") }
    let(:ability) { Ability.new(user) }
    describe 'can' do
      it { expect(ability).to be_able_to(:manage, Project.new(user: user)) }
    end
    describe 'can not' do
      it { expect(ability).not_to be_able_to(:manage, Project.new(user: other_user)) }
    end
  end
end
