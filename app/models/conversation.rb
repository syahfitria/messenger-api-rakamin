class Conversation < ApplicationRecord
  belongs_to :sender, foreign_key: :sender_id,class_name: User.name
  belongs_to :recipient, foreign_key: :recipient_id, class_name: User.name
  has_many :conversation_messages

  def can_accessed_by?(user)
    [sender, recipient].include?(user)
  end
end
