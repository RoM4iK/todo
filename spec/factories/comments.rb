FactoryGirl.define do
  factory :comment do
    text Faker::Hipster.sentence

    after :build do |comment, evaluator|
      if comment.user.blank?
        comment.user = build(:user)
      end
    end

    after :create do |comment, evaluator|
      if comment.user.blank?
        comment.user = create(:user)
      end
    end
  end
end
