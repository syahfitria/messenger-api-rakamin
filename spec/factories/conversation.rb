FactoryBot.define do
  factory :conversation do
    sender factory: :user
    recipient factory: :user
  end
end
