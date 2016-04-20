FactoryGirl.define do
  factory :project do
    title Faker::Commerce.department

    after :build do |project, evaluator|
      if project.user.blank?
        project.user = build(:user)
      end
    end

    after :create do |project, evaluator|
      if project.user.blank?
        project.user = create(:user)
      end
    end
  end
end
