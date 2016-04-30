FactoryGirl.define do
  factory :comment do
    text Faker::Hipster.sentence
    sequence :uuid do |n|
      "#{Faker::Lorem.characters(15)}#{n}"
    end

    after :build do |comment, evaluator|
      if comment.task.blank?
        comment.task = create(:task)
      end
      if comment.user.blank?
        comment.user = comment.task.project.user
      end
    end
    
    after :create do |comment, evaluator|
      if comment.task.blank?
        comment.task = create(:task)
      end
      if comment.user.blank?
        comment.user = comment.task.project.user
      end
    end
  end
end
