FactoryBot.define do
  factory :conversation_message do
    body { Faker::Lorem.sentence }
    conversation
    user
  end
end
