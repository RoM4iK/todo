require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  describe 'user' do
    let(:user) { FactoryGirl.create(:user, email: "user@gmail.com") }
    let(:other_user) { FactoryGirl.create(:user, email: "other@gmail.com") }
    let(:ability) { Ability.new(user) }
    describe 'can' do
      before do
        @project = Project.new(user: user)
        @task = Task.new(project: @project)
        @comment =  Comment.new(task: @task)
      end
      it { expect(ability).to be_able_to(:manage, @project) }
      it { expect(ability).to be_able_to(:manage, @task) }
      it { expect(ability).to be_able_to(:manage, @comment) }
    end
    describe 'can not' do
      before do
        @project = Project.new(user: other_user)
        @task = Task.new(project: @project)
        @comment =  Comment.new(task: @task)
      end
      it { expect(ability).not_to be_able_to(:manage, @project) }
      it { expect(ability).not_to be_able_to(:manage, @task) }
      it { expect(ability).not_to be_able_to(:manage, @comment) }
    end
  end
end
