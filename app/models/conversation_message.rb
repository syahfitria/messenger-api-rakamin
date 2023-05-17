class ConversationMessage < ApplicationRecord
  belongs_to :conversation
  belongs_to :user
  validates :body, length: { minimum: 1 }
end
