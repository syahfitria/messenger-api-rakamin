class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:messages, :show]
  before_action :validate_user_access, only: [:messages, :show]

  def index
    conversations = current_user.conversations

    data = conversations.map do |conversation|
      user = conversation.recipient_id == current_user.id ? conversation.sender : conversation.recipient
      message = conversation.conversation_messages.last
      unread = conversation.conversation_messages.where(user_id: conversation.recipient_id).where.not(read: true).count
      {
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
    if @conversation.sender == current_user
      user = @conversation.recipient_id == current_user.id ? @conversation.sender : @conversation.recipient 
      data = {
          id: @conversation.id,
          with_user: {
            id: user.id,
            name: user.name,
            photo_url: user.photo_url
          }
      }
      json_response(data)
    end
  end

  def messages
    messages = @conversation.conversation_messages
    data = messages.map do |message|
      sender = message.user
      {
        id: message.id,
        message: message.body,
        sender: {
          id: sender.id,
          name: sender.name
        },
        sent_at: message.created_at
      }
    end
    json_response(data)

    
  end

  private

  def validate_user_access
    raise(ExceptionHandler::ForbiddenAccess,
      Message.unauthorized) unless @conversation.can_accessed_by?(current_user)
  end

  def set_conversation
    @conversation = Conversation.find(params[:id])
  end

end