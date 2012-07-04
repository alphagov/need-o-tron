FactoryGirl.define do
  factory :user do
    uid { "ABC" }
    name { "T Est" }
    email { "test@example.com" }
    version { 1 }
    permissions { Hash[GDS::SSO::Config.default_scope => ["signin"]] }
  end
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
