FactoryGirl.define do
  factory :task do
    title Faker::Hipster.sentence
    sequence :uuid do |n|
      "#{Faker::Lorem.characters(15)}#{n}"
    end


    after :build do |task, evaluator|
      if task.project.blank?
        task.project = create(:project)
      end
    end

    after :create do |task, evaluator|
      if task.project.blank?
        task.project = create(:project)
      end
    end
  end
end
