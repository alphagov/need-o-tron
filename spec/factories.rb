FactoryGirl.define do
  factory :need do
    status Need::NEW
  end
  factory :kind do
    sequence(:name) {|n| "kind#{n}"}
  end
  factory :writing_department do
    sequence(:name) {|n| "writing department #{n}"}
  end
end
