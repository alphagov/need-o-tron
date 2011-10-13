FactoryGirl.define do
  factory :need do
    status Need::NEW
  end
  factory :kind do
    sequence(:name) {|n| "kind#{n}"}
  end
end
