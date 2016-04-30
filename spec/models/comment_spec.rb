require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to :user }
  it { should belong_to :task }
  it { should have_attached_file(:image) }
  it { should validate_attachment_content_type(:image).
                allowing('image/png', 'image/gif').
                rejecting('text/plain', 'text/xml') }
  it { should validate_presence_of :uuid }
  it { FactoryGirl.create(:comment); should validate_uniqueness_of :uuid }
  it { should validate_presence_of :text }
  it { should validate_presence_of :image }
  context "When text is present" do
    before do
      subject.text = "Lorem ipsum?"
    end
    it { should_not validate_presence_of :image }
  end
  context "When image is present" do
    before do
      subject.image = File.new("#{Rails.root}/spec/support/fixtures/image.png")
    end
    it { should_not validate_presence_of :text }
  end
end
