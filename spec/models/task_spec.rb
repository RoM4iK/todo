require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should validate_presence_of :uuid }
  it { FactoryGirl.create(:task); should validate_uniqueness_of :uuid }
  it { should validate_presence_of :title }
  it { should belong_to :project }
end
