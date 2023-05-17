class Conversation < ApplicationRecord
  belongs_to :sender, foreign_key: :sender_id,class_name: User.name
  belongs_to :recipient, foreign_key: :recipient_id, class_name: User.name
  has_many :conversation_messages

  def can_accessed_by?(user)
    [sender, recipient].include?(user)
  end

  def self.between(sender_id, recipient_id)
    where(sender_id: sender_id, recipient_id: recipient_id).or(
      where(sender_id: recipient_id, recipient_id: sender_id)
    ).first
  end
  
end
