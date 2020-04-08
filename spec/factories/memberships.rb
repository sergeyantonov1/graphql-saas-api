FactoryBot.define do
  factory :membership do
    user
    company
    role { "member" }
  end
end
