require 'rails_helper'

RSpec.describe Project, type: :model do
  it { should validate_presence_of :uuid }
  it { FactoryGirl.create(:project); should validate_uniqueness_of :uuid }
  it { should validate_presence_of :title }
  it { should belong_to :user }
  it { should have_many :tasks }
end
