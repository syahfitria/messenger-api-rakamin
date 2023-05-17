class User < ApplicationRecord
  
  has_many :conversations, foreign_key: :sender_id
  has_many :recepient_conversations, foreign_key: :recipient_id, class_name: 'Conversation'

  has_many :conversation_messages, through: :conversations
  has_many :recepient_messages, through: :recepient_conversations, source: :conversation_messages
  # encrypt password
  has_secure_password
end
