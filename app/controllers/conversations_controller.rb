class ConversationsController < ApplicationController

  def index
    conversations = current_user.conversations
    data = []

    conversations_serialized = conversations.map do |conversation|
      user = conversation.recipient_id == current_user.id ? conversation.sender : conversation.recipient
      message = conversation.conversation_messages.last
      unread = conversation.conversation_messages.where(user_id: conversation.recipient_id).where.not(read: true).count
      data << {
        id: conversation.id,
        with_user: {
          id: user.id,
          name: user.name,
          photo_url: user.photo_url
        },
        last_message: {
          id: message.id,
          sender: {
            id: message.user.id,
            name: message.user.name
          },
          sent_at: message.created_at
        },
        unread_count: unread
      }
    end
    json_response(data)
  end

  def show
    conversation = Conversation.find(params[:id])
    if conversation
      raise(ExceptionHandler::ForbiddenAccess,
      Message.unauthorized) unless conversation.can_accessed_by?(current_user)
      if conversation.sender == current_user
        user = conversation.recipient_id == current_user.id ? conversation.sender : conversation.recipient 
        data = {
            id: conversation.id,
            with_user: {
              id: user.id,
              name: user.name,
              photo_url: user.photo_url
            }
        }
        json_response(data)
      end
    end
  end

end