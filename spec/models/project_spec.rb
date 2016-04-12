require 'rails_helper'

RSpec.describe Project, type: :model do
  it { validate_presence_of :title }
  it { belong_to :user }
end
